//
//  ViewController2.swift
//  RYFloatingInput_Example
//
//  Created by Manan Devani on 24/09/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import RYFloatingInput

class customcell: UITableViewCell {
//    @IBOutlet var constraint: NSLayoutConstraint!
    @IBOutlet var textInput: RYFloatingInput!
}

class ViewController2: UIViewController {
    @IBOutlet var tableview: UITableView!
    
    var data = ["contracted"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension ViewController2: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "c", for: indexPath) as! customcell
        configure(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! customcell
        configure(cell: cell, indexPath: indexPath)
        cell.textInput.triggerWarning("This is warning")
        cell.layoutIfNeeded()
        tableview.beginUpdates()
        tableview.endUpdates()
    }
    
    func configure(cell: customcell, indexPath: IndexPath) {
        let data = self.data[indexPath.row]
    
        if data == "expanded" {
//            cell.constraint.constant = 200
            self.data[indexPath.row] = "contracted"
        } else {
//            cell.constraint.constant = 30
            self.data[indexPath.row] = "expanded"
        }
        
        cell.layoutIfNeeded()
        tableview.beginUpdates()
        tableview.endUpdates()
    }
}
