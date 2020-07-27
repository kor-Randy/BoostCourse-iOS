//
//  ImageZoomViewController.swift
//  PhotosExample
//
//  Created by 지현우 on 2020/07/17.
//  Copyright © 2020 kor-Randy. All rights reserved.
//

import UIKit
import Photos

class ImageZoomViewController: UIViewController, UIScrollViewDelegate {

    var asset : PHAsset! // 전 화면에서 받아올 에셋
    let imageManager: PHCachingImageManager = PHCachingImageManager() // 이미지 요청
    
    @IBOutlet weak var imageView : UIImageView!
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        //스크롤 뷰 Delegate 메소드
        return self.imageView // 줌을 해줄 View를 리턴
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: nil, resultHandler: {
            image, _ in
            self.imageView.image = image
        })
        
        // Do any additional setup after loading the view.
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
