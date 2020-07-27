//
//  ViewController.swift
//  LoginProject
//
//  Created by 지현우 on 2020/07/14.
//  Copyright © 2020 kor-Randy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var idText : UITextField!
    @IBOutlet weak var passText : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindVC1(segue: UIStoryboardSegue){

    print("helloooo")
    if(AccountSingleton.accountSingleton.id != nil){
        idText.text = AccountSingleton.accountSingleton.id!
        passText.text = AccountSingleton.accountSingleton.pass!
    }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    

}

