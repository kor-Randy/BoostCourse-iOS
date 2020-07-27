//
//  SignUpViewController.swift
//  LoginProject
//
//  Created by 지현우 on 2020/07/14.
//  Copyright © 2020 kor-Randy. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    lazy var imagePicker : UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self//이미지픽커의 delegate를 ViewController로 설정함 -> 이미지피커에 어떠한 작용이 될 때 ViewController의 함수를 실행한다?
        return picker
    }()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var idText : UITextField!
    @IBOutlet weak var passText : UITextField!
    @IBOutlet weak var passCheckText: UITextField!
    
    @IBAction func touchUpSelectImageButton(_ sender: UIButton){
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func touchUpSelectImageView(){
        self.present(self.imagePicker,animated:true,completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = self.imageView
        
        let imageViewTap : UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.touchUpSelectImageButton(_:)) )
        imageView?.isUserInteractionEnabled = true
        imageView!.addGestureRecognizer(imageViewTap)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(AccountSingleton.accountSingleton.birthDay != nil){
            self.dismiss(animated: true, completion: nil)
            print("사라져")
        }
        
    }
    
    @IBAction func saveInfo(){
        AccountSingleton.accountSingleton.id = self.idText.text
        AccountSingleton.accountSingleton.pass = self.passText.text
        print(AccountSingleton.accountSingleton.id! + AccountSingleton.accountSingleton.pass!)
        
    }
    @IBAction func checkPass(){
        if(passText.text == passCheckText.text){
            nextButton.isEnabled = true
        }
        else{
            nextButton.isEnabled = false
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage : UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.imageView.image = originalImage
        }
        
        self.dismiss(animated: true, completion: nil)
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
