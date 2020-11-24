//
//  UserCollectionViewController.swift
//  User01
//
//  Created by 北田菜穂 on 2020/11/25.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import UIKit

class UserCollectionViewController: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    
    var userList : [UserData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
}

extension UserCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.userList.icon = self.userList[indexPath.row]
        
        return cell
    }
}


