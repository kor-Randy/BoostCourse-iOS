//
//  AccountSingleTon.swift
//  LoginProject
//
//  Created by 지현우 on 2020/07/14.
//  Copyright © 2020 kor-Randy. All rights reserved.
//

import Foundation

class AccountSingleton{
    
    static let accountSingleton : AccountSingleton = AccountSingleton()
    
    var id : String?
    var pass : String?
    var phoneNum : String?
    var birthDay : String?
    
}
