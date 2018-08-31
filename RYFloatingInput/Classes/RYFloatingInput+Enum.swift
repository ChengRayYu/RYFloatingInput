//
//  RYFloatingInput+Enum.swift
//  RYFloatingInput-Swift
//
//  Created by Ray on 31/08/2017.
//  Copyright © 2017 ycray.net. All rights reserved.
//

import UIKit

public extension RYFloatingInput {
    
    public enum InputType {
        case number
        case regex(pattern: String)
        
        internal var pattern: String? {
            switch self {
            case .number:           return "^[0-9]+$"
            case .regex(let p):     return p
            }
        }
    }
    
    public enum DividerWeight: CGFloat {
        case thin       = 0.5
        case regular    = 1.0
        case bold       = 2.0
    }
    
    public enum Theme {
        
        case standard
        case dark
        case light

        var background: UIColor {
            switch self {
            case .standard: return .white
            case .dark:     return UIColor(hex: 0x263238)
            case .light:    return UIColor(hex: 0xF0E8E1)
            }
        }
        
        var text: UIColor {
            switch self {
            case .standard: return UIColor(hex: 0x212121)
            case .dark:     return UIColor(hex: 0xBDBDBD)
            case .light:    return UIColor(hex: 0x424242)
            }
        }

        var placeholder: UIColor {
            switch self {
            case .standard: return UIColor(hex: 0xC7C7CD)
            case .dark:     return UIColor(hex: 0x616161)
            case .light:    return UIColor(hex: 0xC0B9B4)
            }
        }

        var divider: UIColor {
            switch self {
            case .standard: return UIColor(hex: 0xBDBDBD)
            case .dark:     return UIColor(hex: 0x757575)
            case .light:    return UIColor(hex: 0xB5B2B4)
            }
        }
        
        var cursor: UIColor {
            switch self {
            case .standard: return UIColor(hex: 0x757575)
            case .dark:     return UIColor(hex: 0x2C434E)
            case .light:    return UIColor(hex: 0x757575)
            }
        }

        var accent: UIColor {
            switch self {
            case .standard: return UIColor(hex: 0x01579B)
            case .dark:     return UIColor(hex: 0x9E8C43)
            case .light:    return UIColor(hex: 0x6B7B82)
            }
        }
        
        var warning: UIColor {
            switch self {
            case .standard: return UIColor(hex: 0xB71C1C)
            case .dark:     return UIColor(hex: 0xB23648)
            case .light:    return UIColor(hex: 0xB66E65)
            }
        }
    }
}

internal extension RYFloatingInput {

    internal enum ViolationStatus {
        case valid
        case maxLengthViolated
        case inputTypeViolated
    }

    internal enum HintVisibility {
        case visible
        case hidden
    }
}

private extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}
