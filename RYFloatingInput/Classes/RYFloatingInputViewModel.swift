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

  internal let inputStatusDrv: Driver<RYFloatingInput.Status>
  internal let hintVisibleDrv: Driver<RYFloatingInput.HintVisibility>

  internal init(input: Driver<String>, dependency: (minLength: Int?, maxLength: Int?, inputType: RYFloatingInput.InputType?)) {

    inputStatusDrv = input
      .map({ (content) -> RYFloatingInput.Status in
        guard content.count > 0 else {
          return .notValid(.emptyViolated)
        }
        if let rp = dependency.inputType?.pattern, RYFloatingInputViewModel.regex(pattern: rp, input: content) {
          return .notValid(.inputTypeViolated)
        }
        if let minL = dependency.minLength, content.count < minL {
          return .notValid(.minLengthViolated)
        }
        if let ml = dependency.maxLength, content.count >= ml {
          return .notValid(.maxLengthViolated)
        }
        return .valid
      })

    hintVisibleDrv = input
      .map({ (content) -> RYFloatingInput.HintVisibility in
        return (content.count > 0) ? .visible : .hidden
      })
      .distinctUntilChanged()
  }
}

private extension RYFloatingInputViewModel {

  static func regex(pattern: String, input: String) -> Bool {

    do {
      let regexNumbersOnly = try NSRegularExpression(pattern: pattern, options: [])
      return regexNumbersOnly.firstMatch(in: input, options: [], range: NSMakeRange(0, input.count)) == nil

    } catch let error as NSError {
      print(error.description)
    }
    return true
  }
}
