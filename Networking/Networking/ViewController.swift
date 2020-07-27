//
//  ViewController.swift
//  Networking
//
//  Created by 지현우 on 2020/07/25.
//  Copyright © 2020 kor-Randy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    

    

    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier : String = "friendCell"
    var friends : [Friend] = []
    
    @objc func didReceiveFriendsNotification(_ noti: Notification){
        
        guard let friends: [Friend] = noti.userInfo?["friends"] as? [Friend] else {
            return
        }
        
        self.friends = friends
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveFriendsNotification(_:)), name: DidReceiveFriendsNotification, object: nil)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestFriends()
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let friend: Friend = self.friends[indexPath.row]
        
        cell.textLabel?.text = friend.name.full
        cell.detailTextLabel?.text = friend.email
        cell.imageView?.image = nil // 재사용될 때 다른 이미지를 없앤다
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: friend.picture.thumbnail) else {
                return
            }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else {
                return
            }
            
            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell){
                    // tableView(:cellForRowAt:) 메소드 내의 cell과 사진을 불러올 때의 cell의 row가 다를 수 있기 떄문에
                    //확인을 한 후에 이미지를 설정해준다
                    if index.row == indexPath.row {
                        cell.imageView?.image = UIImage(data: imageData)
                    }
                }
                
            }
            
        }
        
        
        
        
        return cell
    }

}

