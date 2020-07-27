//
//  ViewController.swift
//  Alert
//
//  Created by 지현우 on 2020/07/25.
//  Copyright © 2020 kor-Randy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func touchUpShowAlertButton(_ sender: UIButton){
        self.showAlertController(style: UIAlertController.Style.alert)
    }
    
    @IBAction func touchUpShowActionSheetButton(_ sender : UIButton){
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
    
    func showAlertController(style: UIAlertController.Style){
        let alertController: UIAlertController
        alertController = UIAlertController(title: "Title", message: "Msg", preferredStyle: style)
        
        let okAction: UIAlertAction
        okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) in
            let str : UITextField? = alertController.textFields?[0] as? UITextField
            print("OK pressed \(str?.text)")
        })
        
        let cancelAction : UIAlertAction
        cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        let handler: (UIAlertAction) -> Void
        handler = { (action: UIAlertAction) in
            print("action pressed \(action.title ?? "")")
        }
        
        let someAction: UIAlertAction
        someAction = UIAlertAction(title: "Some", style: UIAlertAction.Style.destructive, handler: handler)
        
        let anotherAction: UIAlertAction
        anotherAction = UIAlertAction(title: "Another", style: UIAlertAction.Style.default, handler: handler)
        
        alertController.addAction(someAction)
        alertController.addAction(anotherAction)
        
        alertController.addTextField { (field: UITextField) in
            field.placeholder = "폴레이스 홀더"
            field.textColor = UIColor.red
        }
        
        
        self.present(alertController,animated: true,completion: {
            print("Alert controller shown")
        }) // completion 블록 -> 모달이 올라오는 애니메이션이 끝난 직후
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

