//
//  RYFloatingInputSetting.swift
//  RYFloatingInput-Swift
//
//  Created by Ray on 26/08/2017.
//  Copyright © 2017 ycray.net. All rights reserved.
//

import UIKit

public extension RYFloatingInputSetting {

    public class Builder {

        fileprivate var _theme: RYFloatingInput.Theme = .standard
        fileprivate var _backgroundColor: UIColor?
        fileprivate var _textColor: UIColor?
        fileprivate var _placeholderColor: UIColor?
        fileprivate var _dividerColor: UIColor?
        fileprivate var _cursorColor: UIColor?
        fileprivate var _accentColor: UIColor?
        fileprivate var _warningColor: UIColor?

        fileprivate var _iconImage: UIImage?
        fileprivate var _dividerWeight: RYFloatingInput.DividerWeight = .regular
        fileprivate var _placeholder: String?
        fileprivate var _secure: Bool = false

        fileprivate var _maxLength: Int?
        fileprivate var _maxLengthViolation: RYFloatingInput.InputViolation?
        fileprivate var _inputType: RYFloatingInput.InputType?
        fileprivate var _inputTypeViolation: RYFloatingInput.InputViolation?

        public static func instance() -> Builder {
            return Builder()
        }

        public func theme(_ theme: RYFloatingInput.Theme) -> Builder {
            _theme = theme
            return self
        }

        public func backgroundColor(_ color: UIColor) -> Builder {
            _backgroundColor = color
            return self
        }

        public func textColor(_ color: UIColor) -> Builder {
            _textColor = color
            return self
        }

        public func placeholderColor(_ color: UIColor) -> Builder {
            _placeholderColor = color
            return self
        }

        public func dividerColor(_ color: UIColor) -> Builder {
            _dividerColor = color
            return self
        }

        public func cursorColor(_ color: UIColor) -> Builder {
            _cursorColor = color
            return self
        }

        public func accentColor(_ color: UIColor) -> Builder {
            _accentColor = color
            return self
        }

        public func warningColor(_ color: UIColor) -> Builder {
            _warningColor = color
            return self
        }

        public func iconImage(_ image: UIImage) -> Builder {
            _iconImage = image
            return self
        }

        public func dividerWeight(_ weight: RYFloatingInput.DividerWeight) -> Builder {
            _dividerWeight = weight
            return self
        }

        public func placeholer(_ placeholder: String) -> Builder {
            _placeholder = placeholder
            return self
        }

        public func secure(_ isSecure: Bool) -> Builder {
            _secure = isSecure
            return self
        }

        public func maxLength(_ length: Int, onViolated violation: RYFloatingInput.InputViolation) -> Builder {
            _maxLength = length
            _maxLengthViolation = violation
            return self
        }

        public func inputType(_ type: RYFloatingInput.InputType, onViolated violation: RYFloatingInput.InputViolation) -> Builder {
            _inputType = type
            _inputTypeViolation = violation
            return self
        }

        public func build() -> RYFloatingInputSetting {
            return RYFloatingInputSetting(builder: self)
        }
    }
}

public class RYFloatingInputSetting {

    internal let backgroundColor: UIColor
    internal let textColor: UIColor
    internal let placeholderColor: UIColor
    internal let dividerColor: UIColor
    internal let cursorColor: UIColor
    internal let accentColor: UIColor
    internal let warningColor: UIColor

    internal let iconImage: UIImage?
    internal let dividerHeight: CGFloat
    internal let placeholder: String?
    internal let isSecure: Bool?

    internal let maxLength: Int?
    internal let maxLengthViolation: RYFloatingInput.InputViolation?
    internal let inputType: RYFloatingInput.InputType?
    internal let inputTypeViolation: RYFloatingInput.InputViolation?

    private init(builder: Builder) {

        self.backgroundColor = builder._backgroundColor ?? builder._theme.background
        self.textColor = builder._textColor ?? builder._theme.text
        self.placeholderColor = builder._placeholderColor ?? builder._theme.placeholder
        self.dividerColor = builder._dividerColor ?? builder._theme.divider
        self.cursorColor = builder._cursorColor ?? builder._theme.cursor
        self.accentColor = builder._accentColor ?? builder._theme.accent
        self.warningColor = builder._warningColor ?? builder._theme.warning

        self.iconImage = builder._iconImage
        self.dividerHeight = builder._dividerWeight.rawValue
        self.placeholder = builder._placeholder
        self.isSecure = builder._secure

        self.maxLength = builder._maxLength
        self.maxLengthViolation = builder._maxLengthViolation
        self.inputType = builder._inputType
        self.inputTypeViolation = builder._inputTypeViolation
    }


}

