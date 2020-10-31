//
//  File.swift
//  User01
//
//  Created by 北田菜穂 on 2020/10/23.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import Foundation

protocol UserSearchUseCaseDelegate : class {
    func onSearchSuccess(_ data : [UserData])
    func onSearchEmpty()
    func onSearchError()
}

class UserSearchUseCase {
    
    func search(_ query : String){
        
    }
    
}
