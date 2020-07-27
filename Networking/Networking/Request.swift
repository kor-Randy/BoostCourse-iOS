//
//  Request.swift
//  Networking
//
//  Created by 지현우 on 2020/07/26.
//  Copyright © 2020 kor-Randy. All rights reserved.
//

import Foundation

let DidReceiveFriendsNotification: Notification.Name = Notification.Name("DidReceiveFriends")

func requestFriends(){
    guard let url: URL = URL(string: "https://randomuser.me/api/?results=20&inc=name,email,picture") else {
                return
            }
            
            let session : URLSession = URLSession(configuration: .default)
            let dataTask: URLSessionDataTask = session.dataTask(with: url) {
                (data:Data?, response: URLResponse?, error: Error?) in
                //백그라운드에서 실행됨
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data else {return}
            
                do{
                    let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    NotificationCenter.default.post(name: DidReceiveFriendsNotification, object: nil, userInfo: ["friends": apiResponse.results])
                    //발송하는 쓰레드에서 발송하면 수신측도 같은 쓰레드에서 실행됨
                    
    //                self.tableView.reloadData()
                } catch(let err) {
                    print(err.localizedDescription)
                }
                
            }
            
            dataTask.resume()
}
