//
//  UserSearchRepository.swift
//  User01
//
//  Created by 北田菜穂 on 2020/10/23.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import Foundation

protocol UserSearchRepositoryDelegate : class {
    func onSearchiFinish(_ data : [String:Any])
}

class UserSearchRepository {
    
    weak var delegate : UserSearchRepositoryDelegate?
    
    func search(_ query : String){
        self.delegate?.onSearchiFinish([:])
    }
    
}
