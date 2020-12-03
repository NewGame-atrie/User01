//
//  UICollectionViewCell2.swift
//  User01
//
//  Created by 北田菜穂 on 2020/11/27.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//


import UIKit

class UserDataCollectionViewCell2 : UICollectionViewCell {
    
    @IBOutlet var textLabel : UILabel!
    @IBOutlet var detailTextLabel : UILabel!
    @IBOutlet var imageView : UIImageView!
    
    var user : UserData? {
        didSet {
            self.configure()
        }
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
        self.setup()
    }
    
    private func setup(){
       
    }
    
    private func configure(){
        
        guard let user : UserData = self.user else {
            return
        }
        
        //title
        self.textLabel.text = user.name
        
        //type
        self.detailTextLabel.text = user.type
        
        //image
        self.imageView.image = UIImage(named: "loading")
        if let icon = user.icon, let imageUrl = URL(string: icon) {
            self.imageView.af.setImage(withURL: imageUrl)
        }
        
        
    }
}

