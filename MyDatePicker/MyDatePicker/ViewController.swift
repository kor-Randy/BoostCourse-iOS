//
//  ViewController.swift
//  MyDatePicker
//
//  Created by 지현우 on 2020/07/14.
//  Copyright © 2020 kor-Randy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel : UILabel!
    let dateFormatter: DateFormatter = {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        return formatter
    }()
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker){
        print("Value Changed")
        
        let date: Date = sender.date
        //let date: Date = self.datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        self.dateLabel.text = dateString
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
        // Do any additional setup after loading the view.
    }


}

