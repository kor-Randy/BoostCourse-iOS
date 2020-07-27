//
//  ViewController.swift
//  PhotosExample
//
//  Created by 지현우 on 2020/07/15.
//  Copyright © 2020 kor-Randy. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PHPhotoLibraryChangeObserver {
    
    
    
    

    @IBOutlet weak var tableView: UITableView!
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()//가져온 에셋을 가지고 로드해오는 애
    let cellIdentifier: String = "cell"
    
    @IBAction func touchUpRefreshButton(_ sender : UIBarButtonItem){
        self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
    }
    
    func requestCollection(){
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)//사진 찍으면 저장되는 카메라 롤 생성
        
        guard let cameraRollCollection = cameraRoll.firstObject else{
            return
        }

        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]//최신순으로 Sort
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
        //fetchResult에 생성한 카메라롤컬렉션에서 옵션(정렬)한 사진들은 저장한다
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus() //접근 상태 가져오기
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("접근 허가됨")
            self.requestCollection()
        case .denied:
            print("접근 불허")
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization { (status) in switch status{
                case .authorized:
                    print("사용자가 허용함")
                    self.requestCollection()
                    OperationQueue.main.addOperation { //main쓰레드에서 실행 ??
                        self.tableView.reloadData() // reloadData는 메인스레드에서만 돌아야한다.
                    }
                    
                case .denied:
                    print("사용자가 불허함")
                default: break
                }
            }
        case .restricted:
            print("접근 제한")
        
        }
        PHPhotoLibrary.shared().register(self) // 포토라이브러리가 변화할 때마다 delegate 메소드가 실행된다.
        
    }
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult) else {
            return
        }
        
        fetchResult = changes.fetchResultAfterChanges
        //무엇이 바뀌었는지?
        
        OperationQueue.main.addOperation {
            self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
            //바뀌었으면 리로드한다
        }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //각 Row를 편집가능하게 할 것인가?
        
        
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //편집을 할 때 삭제 라면
            let asset: PHAsset = self.fetchResult[indexPath.row]
            //해당 Row의 Asset를 가져온다
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.deleteAssets([asset] as NSArray)
            }, completionHandler: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0 //fetchResult의 갯수를 리턴 , nil이라면 0 리턴
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //각 셀에 데이터 입력 및 셀 생성
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        //재활용 큐를 생성하여 재활용한다
        
        let asset: PHAsset = fetchResult.object(at: indexPath.row)
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 30, height: 30), contentMode: .aspectFill, options: nil, resultHandler: {
            image, _ in cell.imageView?.image = image
        })
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewConteroller: ImageZoomViewController = segue.destination as? ImageZoomViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        guard let index: IndexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        
        nextViewConteroller.asset = self.fetchResult[index.row]
    }

}

