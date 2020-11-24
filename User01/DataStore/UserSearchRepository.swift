//
//  UserSearchRepository.swift
//  User01
//
//  Created by 北田菜穂 on 2020/10/23.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import Foundation
import Alamofire

protocol UserSearchRepositoryDelegate : class {
    func onSearchFinish(_ data : [String:Any])
    func onSearchError(_ error : Error)
}

class UserSearchRepository {
    
    weak var delegate : UserSearchRepositoryDelegate?
    
    func search(_ query : String){
        
        let url = "https://api.github.com/search/users?q=\(query)"
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                
                switch response.result{
                    case.success:
                        if let data = response.value {
                            self.onSuccess(data)
                        }
                        break
                    
                    case let .failure(error):
                        self.onError(error)
                        break
                }
            }
       
    }
    
    private func onSuccess(_ value : Any){
        
        guard let value = value as? [String:Any] else {
            return
        }
        
        self.delegate?.onSearchFinish(value)
        
    }
    
    private func onError(_ error : Error){
        
        self.delegate?.onSearchError(error)
        
    }
    
}
