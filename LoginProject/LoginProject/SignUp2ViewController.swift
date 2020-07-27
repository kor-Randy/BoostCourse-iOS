//
//  SignUp2ViewController.swift
//  LoginProject
//
//  Created by 지현우 on 2020/07/14.
//  Copyright © 2020 kor-Randy. All rights reserved.
//

import UIKit

class SignUp2ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var phoneNumber : UITextField!
    
    let dateFormatter: DateFormatter = {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker){
        print("Value Changed")
        
        //let date: Date = sender.date
        let date: Date = self.datePicker.date
        
        AccountSingleton.accountSingleton.birthDay = self.dateFormatter.string(from: date)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
        // Do any additional setup after loading the view.
    }
    
//    @IBAction func saveInfo(){
//     }
    
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue){
        AccountSingleton.accountSingleton.phoneNum = phoneNumber.text
        performSegue(withIdentifier: "unwindVC1", sender: self)
    }
    
    @IBAction func unwindToMainCancel(_ unwindSegue: UIStoryboardSegue){
        performSegue(withIdentifier: "unwindVC1", sender: self)
    }
    
    @IBAction func dismissModal(){
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
