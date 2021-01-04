//
//  UserDataCell.swift
//  User01
//
//  Created by 北田菜穂 on 2020/10/23.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import UIKit

class UserDataCell: UITableViewCell {
    
    var user : UserData? {
        didSet {
            self.configure()
        }
    }
    init(){
        super.init(style: .subtitle, reuseIdentifier: "UserDataCell")
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* */
    
    private func setup(){
        
        self.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        self.detailTextLabel?.textColor = UIColor.gray
        self.imageView?.clipsToBounds = true
        self.imageView?.contentMode = .scaleAspectFit
        self.imageView?.frame.size = CGSize(width: 64, height: 64)
        self.setNeedsLayout()
    }
    
    private func configure(){
        
        guard let user : UserData = self.user else {
            return
        }
        
        //title
        self.textLabel?.text = user.name
        
        //type
        self.detailTextLabel?.text = user.type
        
        //image
        self.imageView?.image = UIImage(named: "loading")
        if let icon = user.icon, let imageUrl = URL(string: icon) {
            self.imageView?.af.setImage(withURL: imageUrl)
        }
        
        
    }
}
