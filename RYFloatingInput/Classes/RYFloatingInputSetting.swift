//
//  RYFloatingInputSetting.swift
//  RYFloatingInput-Swift
//
//  Created by Ray on 26/08/2017.
//  Copyright © 2017 ycray.net. All rights reserved.
//

import UIKit

public extension RYFloatingInputSetting {

    class Builder {

        fileprivate var _theme: RYFloatingInput.Theme = .standard
        fileprivate var _backgroundColor: UIColor?
        fileprivate var _textColor: UIColor?
        fileprivate var _placeholderColor: UIColor?
        fileprivate var _dividerColor: UIColor?
        fileprivate var _cursorColor: UIColor?
        fileprivate var _hintAccentColor: UIColor?
        fileprivate var _dividerAccentColor: UIColor?
        fileprivate var _warningColor: UIColor?

        fileprivate var _iconImage: UIImage?
        fileprivate var _rightIconImage: UIImage?
        fileprivate var _dividerWeight: RYFloatingInput.DividerWeight = .regular
        fileprivate var _placeholder: String?
        fileprivate var _warning: String?
        fileprivate var _secure: Bool = false
        fileprivate var _keyboardType: UIKeyboardType = .default
        fileprivate var _maxLength: Int?
        fileprivate var _maxLengthViolation: RYFloatingInput.InputViolation?
        fileprivate var _inputType: RYFloatingInput.InputType?
        fileprivate var _inputTypeViolation: RYFloatingInput.InputViolation?

        public func keyboardType(_ type: UIKeyboardType) -> Builder {
            _keyboardType = type
            return self
        }
        
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

        public func dividerAccentColor(_ color: UIColor) -> Builder {
            _dividerAccentColor = color
            return self
        }
        
        public func hintAccentColor(_ color: UIColor) -> Builder {
            _hintAccentColor = color
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
        
        public func rightIconImage(_ image: UIImage) -> Builder {
            _rightIconImage = image
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
        
        public func warning(_ warning: String) -> Builder {
            _warning = warning
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
    internal let hintAccentColor: UIColor
    internal let dividerAccentColor: UIColor
    internal let warningColor: UIColor

    internal let keyboardType: UIKeyboardType
    internal let iconImage: UIImage?
    internal let rightIconImage: UIImage?
    
    internal let dividerHeight: CGFloat
    internal let placeholder: String?
    internal let warning: String?
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
        self.hintAccentColor = builder._hintAccentColor ?? builder._theme.accent
        self.dividerAccentColor = builder._dividerAccentColor ?? builder._theme.accent
        self.warningColor = builder._warningColor ?? builder._theme.warning

        self.iconImage = builder._iconImage
        self.rightIconImage = builder._rightIconImage
        
        self.dividerHeight = builder._dividerWeight.rawValue
        self.placeholder = builder._placeholder
        self.warning = builder._warning
        self.isSecure = builder._secure

        self.maxLength = builder._maxLength
        self.maxLengthViolation = builder._maxLengthViolation
        self.inputType = builder._inputType
        self.inputTypeViolation = builder._inputTypeViolation
        self.keyboardType = builder._keyboardType
    }


}

