//
//  RYFloatingInputSetting.swift
//  RYFloatingInput-Swift
//
//  Created by Ray on 26/08/2017.
//  Copyright © 2017 ycray.net. All rights reserved.
//

import UIKit

public class RYFloatingInputSetting {

    internal var backgroundColor: UIColor
    internal var textColor: UIColor
    internal var placeholderColor: UIColor
    internal var dividerColor: UIColor
    internal var cursorColor: UIColor
    internal var accentColor: UIColor
    internal var warningColor: UIColor
    
    internal var iconImage: UIImage?
    internal var placeholder: String?
    internal var isSecure: Bool = false
    
    internal var maxLength: Int?
    internal var maxLengthViolation: RYFloatingInputViolation?
    internal var inputType: RYFloatingInput.InputType?
    internal var inputTypeViolation: RYFloatingInputViolation?
    
    private init(builder: Builder) {
        
        self.backgroundColor = builder._backgroundColor ?? builder._theme.background
        self.textColor = builder._textColor ?? builder._theme.text
        self.placeholderColor = builder._placeholderColor ?? builder._theme.placeholder
        self.dividerColor = builder._dividerColor ?? builder._theme.divider
        self.cursorColor = builder._cursorColor ?? builder._theme.cursor
        self.accentColor = builder._accentColor ?? builder._theme.accent
        self.warningColor = builder._warningColor ?? builder._theme.warning

        self.iconImage = builder._iconImage
        self.placeholder = builder._placeholder
        self.isSecure = builder._secure

        self.maxLength = builder._maxLength
        self.maxLengthViolation = builder._maxLengthViolation
        self.inputType = builder._inputType
        self.inputTypeViolation = builder._inputTypeViolation
    }
    
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
        fileprivate var _placeholder: String?
        fileprivate var _secure: Bool = false
        
        fileprivate var _maxLength: Int?
        fileprivate var _maxLengthViolation: RYFloatingInputViolation?
        fileprivate var _inputType: RYFloatingInput.InputType?
        fileprivate var _inputTypeViolation: RYFloatingInputViolation?
        
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
        
        public func placeholer(_ placeholder: String) -> Builder {
            _placeholder = placeholder
            return self
        }
        
        public func secure(_ isSecure: Bool) -> Builder {
            _secure = isSecure
            return self
        }
        
        public func maxLength(_ length: Int, onViolated violation: RYFloatingInputViolation) -> Builder {
            _maxLength = length
            _maxLengthViolation = violation
            return self
        }
        
        public func inputType(_ type: RYFloatingInput.InputType, onViolated violation: RYFloatingInputViolation) -> Builder {
            _inputType = type
            _inputTypeViolation = violation
            return self
        }

        public func build() -> RYFloatingInputSetting {
            return RYFloatingInputSetting(builder: self)
        }
    }
}

