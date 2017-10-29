//
//  RYFloatingInputViewModel.swift
//  RYFloatingInput-Swift
//
//  Created by Ray on 11/09/2017.
//  Copyright © 2017 ycray.net. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

internal class RYFloatingInputViewModel {
    
    internal enum ViolationStatus {
        case valid
        case maxLengthViolated
        case inputTypeViolated
    }
    
    internal let inputViolated: Observable<ViolationStatus>
    internal let highlightFloatinHint: Observable<Bool>
    
    private static var floatingHintHighlighted: Bool = false

    init(input: Observable<String?>, dependency: (maxLength: Int?, regexPattern: String?)) {
     
        inputViolated = input.map({ (inputStr) -> ViolationStatus in
            
            guard let content = inputStr, content.characters.count > 0 else {
                return .valid
            }
            if let rp = dependency.regexPattern, RYFloatingInputViewModel.regex(pattern: rp, input: content) {
                return .inputTypeViolated
            }
            if let ml = dependency.maxLength, content.characters.count > ml {
                return .maxLengthViolated
            }            
            return .valid
        })

        highlightFloatinHint = input.map({ (inputStr) -> Bool in

            guard let content = inputStr else {
                RYFloatingInputViewModel.floatingHintHighlighted = false
                return RYFloatingInputViewModel.floatingHintHighlighted
            }
            if content.characters.count == 0 {
                RYFloatingInputViewModel.floatingHintHighlighted = false
            }
            if content.characters.count > 0, RYFloatingInputViewModel.floatingHintHighlighted == false {
                RYFloatingInputViewModel.floatingHintHighlighted = true
            }
            return RYFloatingInputViewModel.floatingHintHighlighted
        })
    }
    
    private static func regex(pattern: String, input: String) -> Bool {
        
        do {
            let regexNumbersOnly = try NSRegularExpression(pattern: pattern, options: [])
            return regexNumbersOnly.firstMatch(in: input, options: [], range: NSMakeRange(0, input.characters.count)) == nil
            
        } catch let error as NSError {
            print(error.description)
        }
        return true
    }
}
