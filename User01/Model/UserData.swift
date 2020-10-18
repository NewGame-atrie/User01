//
//  UserData.swift
//  User01
//
//  Created by 北田菜穂 on 2020/10/09.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import UIKit

class UserData {
    var name : String?
    var url : String?
    var type : String?
    var icon : String?
    
    //Githubのデータを変換する
    //let user = UserData.convert(data)
    static func convert(_ data : [String:Any]) -> UserData {
        let userData = UserData()
        
        userData.name = data["login"] as? String
        userData.url = data["html_url"] as? String
        userData.type = data["type"] as? String
        userData.icon = data["avatar_url"] as? String

        
        return userData
    }
    
}
