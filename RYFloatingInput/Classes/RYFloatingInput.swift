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
        self.input.isSecureTextEntry = setting.isSecure
        self.input.attributedPlaceholder = NSAttributedString(string: setting.placeholder ?? "",
                                                              attributes: [NSAttributedStringKey.foregroundColor: setting.placeholderColor])
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
    
    public func enabled() {
        self.input.isUserInteractionEnabled = true
    }
    
    public func disabled() {
        self.input.isUserInteractionEnabled = false
    }
    
    public override func resignFirstResponder() -> Bool {
        return input.resignFirstResponder()
    }
}

public typealias RYFloatingInputViolation = (message: String, callback: (() -> Void)?)

public class RYFloatingInput: UIView {
    
    // Components
    @IBOutlet fileprivate weak var icon: UIImageView!
    @IBOutlet fileprivate weak var floatingHint: UILabel!
    @IBOutlet fileprivate weak var input: UITextField!
    @IBOutlet fileprivate weak var divider: UIView!
    @IBOutlet fileprivate weak var dividerHeight: NSLayoutConstraint!
    @IBOutlet fileprivate weak var warningLbl: UILabel!
    @IBOutlet fileprivate weak var inputLeadingMargin: NSLayoutConstraint!
    
    // FloatingHintStatus
    private enum FloatingHintStatus { case visible, hidden }
    private var floatingHintStatus: FloatingHintStatus = .hidden
    
    // Settings
    fileprivate var setting: RYFloatingInputSetting?
    
    // Rx Dispose
    let dispose = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
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
        
        self.input.rx.controlEvent([.editingDidEnd, .editingDidBegin])
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.divider.backgroundColor = (self?.input.isFirstResponder)! ? self?.setting?.accentColor : self?.setting?.dividerColor
            })
            .disposed(by: dispose)
        
        let vm = RYFloatingInputViewModel(input: self.input.rx.text.asObservable(),
                                          dependency: (maxLength: self.setting?.maxLength, regexPattern: self.setting?.inputType?.pattern))
        
        vm.inputViolated.bind { [weak self] (status) in
            
            var _violation: RYFloatingInputViolation? = nil
            switch status {
            case .valid:
                self?.floatingHint.textColor = self?.setting?.accentColor
                self?.warningLbl.text = nil
                if (self?.input.isFirstResponder)! { self?.divider.backgroundColor = self?.setting?.accentColor }
                return

            case .maxLengthViolated:    _violation = self?.setting?.maxLengthViolation
            case .inputTypeViolated:    _violation = self?.setting?.inputTypeViolation
            }
            
            guard let voilation = _violation else {
                return
            }
            self?.floatingHint.textColor = self?.setting?.warningColor
            if (self?.input.isFirstResponder)! { self?.divider.backgroundColor = self?.setting?.warningColor }
            self?.warningLbl.text = voilation.message
            self?.warningLbl.textColor = self?.setting?.warningColor

            if let callback = voilation.callback {
                callback()
            }
        }.disposed(by: dispose)
        
        vm.highlightFloatinHint.bind { [weak self] (flag) in
            
            if flag, self?.floatingHintStatus == .hidden {
                self?.floatingHintStatus = .visible
                self?.showFloatingHint()
            }            
            if flag == false {
                self?.floatingHintStatus = .hidden
                self?.hideFloatingHint()
            }
        }.disposed(by: dispose)
    }
    
    private func showFloatingHint() {
        UIView.animate(withDuration: 0.25) {
            self.floatingHint.isHidden = false
            self.floatingHint.alpha = 1.0
            self.floatingHint.text = self.setting?.placeholder
        }
    }
    
    private func hideFloatingHint() {
        self.floatingHint.isHidden = true        
        self.floatingHint.alpha = 0.0
        self.floatingHint.text = nil
    }
}
