//
//  ViewController.swift
//  AsyncExample
//
//  Created by 지현우 on 2020/07/15.
//  Copyright © 2020 kor-Randy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func touchUpDownloadButton(_ sender: UIButton){
        //이미지 다운로드 -> 이미지 뷰에 셋팅
        
        
        guard let imageURL: URL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/LARGE_elevation.jpg/1600px-LARGE_elevation.jpg")
            else{
                return
        }
        
        
                 
        OperationQueue().addOperation {
            // 별도 쓰레드에서 실행
            guard let imageData : Data = try? Data.init(contentsOf: imageURL) else{
                return
            }
            
            guard let image: UIImage = UIImage(data: imageData) else {
                return
            }
            OperationQueue.main.addOperation {
                
                self.imageView.image = image // UI작업이기 때문에 Main Thread에서 해야함
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

