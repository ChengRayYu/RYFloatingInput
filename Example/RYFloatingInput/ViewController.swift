//
//  ViewController.swift
//  RYFloatingInput
//
//  Created by eebolue on 10/28/2017.
//  Copyright (c) 2017 eebolue. All rights reserved.
//

import UIKit
import RYFloatingInput

class ViewController: UIViewController {

    @IBOutlet weak var cellInput: RYFloatingInput!
    @IBOutlet weak var emailInput: RYFloatingInput!
    @IBOutlet weak var firstNameInput: RYFloatingInput!
    @IBOutlet weak var lastNameInput: RYFloatingInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let email_regex_pattern = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
            "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        
        cellInput.setup(setting: RYFloatingInputSetting.Builder.instance()
            .placeholer("Cellphone")
            .iconImage(UIImage(named: "ic_num")!)
            .maxLength(10, onViolated: (message: "Exceed Max Length", callback: nil))
            .inputType(.number, onViolated: (message: "Number Only", callback: nil))
            .build())
        
        emailInput.setup(setting: RYFloatingInputSetting.Builder.instance()
            .placeholer("Email ")
            .iconImage(UIImage(named: "ic_email")!)
            .inputType(.regex(pattern: email_regex_pattern), onViolated: (message: "Invalid Email Format", callback: nil))
            .build())
        
        firstNameInput.setup(setting: RYFloatingInputSetting.Builder.instance()
            .placeholer("First Name")
            .build())
        
        lastNameInput.setup(setting: RYFloatingInputSetting.Builder.instance()
            .placeholer("Last Name")
            .build())
        
        self.view.backgroundColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func backgroundOnTap(_ sender: Any) {
        _ = cellInput.resignFirstResponder()
        _ = emailInput.resignFirstResponder()
        _ = firstNameInput.resignFirstResponder()
        _ = lastNameInput.resignFirstResponder()
    }
}

