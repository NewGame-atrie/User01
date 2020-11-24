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
        
        do {
            let decorder = JSONDecoder()
            decorder.keyDecodingStrategy = .convertFromSnakeCase
            
            let json = try JSONSerialization.data(withJSONObject: data, options: [])
            let converted = try decorder.decode(UserDataCodable.self, from: json)
            
            userData.name = converted.login
            userData.url = converted.htmlUrl
            userData.type = converted.type
            userData.icon = converted.avatarUrl
            
        } catch {
            print("json decode error:\(error)")
        }

        return userData
    }
    
}

class UserDataCodable : Decodable {
    
    var login : String
    var htmlUrl : String
    var type : String
    var avatarUrl : String
    
}
