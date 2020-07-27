//
//  ViewController.swift
//  TapGesture
//
//  Created by 지현우 on 2020/07/14.
//  Copyright © 2020 kor-Randy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    //얘는 Target-Action 과 스토리보드에서의 연결 두개에서 사용
    @IBAction func tapView(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //이건 target-Action 디자인 패턴
//        let tapGesture : UITapGestureRecognizer =
//            UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
//        self.view.addGestureRecognizer(tapGesture)
        
        
        // 이 밑으로는 Delegate 디자인 패턴
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }

}

