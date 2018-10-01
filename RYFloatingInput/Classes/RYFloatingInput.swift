//
//  RYFloatingInput.swift
//  RYFloatingInput-Swift
//
//  Created by Ray on 25/08/2017.
//  Copyright © 2017 ycray.net. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public extension RYFloatingInput {

    public func setup(setting: RYFloatingInputSetting) {

        self.setting = setting

        self.backgroundColor = setting.backgroundColor
        self.icon.image = setting.iconImage
        self.input.textColor = setting.textColor
        self.input.tintColor = setting.cursorColor
        self.dividerHeight.constant = setting.dividerHeight
        self.input.placeholder = setting.placeholder
        self.input.isSecureTextEntry = setting.isSecure ?? false
        self.input.attributedPlaceholder = NSAttributedString(string: setting.placeholder ?? "",
                                                              attributes: [NSAttributedString.Key.foregroundColor: setting.placeholderColor])
        self.divider.backgroundColor = setting.dividerColor
        self.warningLbl.textColor = setting.accentColor

        if setting.iconImage != nil {
            inputLeadingMargin.constant = 48
        }
        self.rx()
    }

    public func text() -> String? {
        return self.input.text
    }

    public func setEnabled(_ flag: Bool? = true) {
        self.input.isUserInteractionEnabled = flag!
    }

    public override func resignFirstResponder() -> Bool {
        return input.resignFirstResponder()
    }
}

public class RYFloatingInput: UIView {

    public typealias InputViolation = (message: String, callback: (() -> Void)?)

    @IBOutlet fileprivate weak var icon: UIImageView!
    @IBOutlet fileprivate weak var floatingHint: UILabel!
    @IBOutlet fileprivate weak var input: UITextField!
    @IBOutlet fileprivate weak var divider: UIView!
    @IBOutlet fileprivate weak var dividerHeight: NSLayoutConstraint!
    @IBOutlet fileprivate weak var warningLbl: UILabel!
    @IBOutlet fileprivate weak var inputLeadingMargin: NSLayoutConstraint!

    fileprivate var setting: RYFloatingInputSetting?
    fileprivate let disposeBag = DisposeBag()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        let view = viewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    private func viewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    fileprivate func rx() {

        input.rx.controlEvent([.editingDidEnd, .editingDidBegin])
            .subscribe(onNext: { _ in
                self.divider.backgroundColor = self.input.isFirstResponder ? self.setting?.accentColor : self.setting?.dividerColor
            })
            .disposed(by: disposeBag)

        let vm = RYFloatingInputViewModel(input: self.input.rx.text.orEmpty.asDriver(),
                                          dependency: (maxLength: self.setting?.maxLength,
                                                       inputType: self.setting?.inputType))

        vm.inputViolatedDrv
            .map({ (status) -> (status: ViolationStatus, violation: InputViolation?)in
                switch status {
                case .valid:                return (status, nil)
                case .inputTypeViolated:    return (status, self.setting?.inputTypeViolation)
                case .maxLengthViolated:    return (status, self.setting?.maxLengthViolation)
                }
            })
            .drive(self.rx.status)
            .disposed(by: disposeBag)

        vm.hintVisibleDrv
            .drive(self.rx.hintVisible)
            .disposed(by: disposeBag)
    }
}

private extension Reactive where Base: RYFloatingInput {

    var status: Binder<(status: RYFloatingInput.ViolationStatus, violation: RYFloatingInput.InputViolation?)> {

        return Binder(base, binding: { (floatingInput, pair) in

            guard let violation = pair.violation else {
                floatingInput.floatingHint.textColor = floatingInput.setting?.accentColor
                floatingInput.warningLbl.text = nil
                if floatingInput.input.isFirstResponder {
                    floatingInput.divider.backgroundColor = floatingInput.setting?.accentColor
                }
                return
            }
            floatingInput.floatingHint.textColor = floatingInput.setting?.warningColor
            if (floatingInput.input.isFirstResponder) {
                floatingInput.divider.backgroundColor = floatingInput.setting?.warningColor
            }
            floatingInput.warningLbl.text = violation.message
            floatingInput.warningLbl.textColor = floatingInput.setting?.warningColor
            if let callback = violation.callback {
                callback()
            }
        })
    }

    var hintVisible: Binder<RYFloatingInput.HintVisibility> {

        return Binder(base, binding: { (floatingInput, visibility) in

            UIView.animate(withDuration: 0.3,  delay: 0.0, options: .curveEaseInOut, animations: {
                floatingInput.floatingHint.isHidden = (visibility != .visible)
                floatingInput.floatingHint.alpha = (visibility == .visible) ? 1.0 : 0.0
                floatingInput.floatingHint.text = (visibility == .visible) ? floatingInput.setting?.placeholder : nil
            })
        })
    }
}
