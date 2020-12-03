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

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        let nib : UINib = UINib(nibName: "UserDataCollectionViewCell2", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "UserDataCollectionViewCell2")
        
    }
}

extension UserCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserDataCollectionViewCell2", for: indexPath) as! UserDataCollectionViewCell2
        
        cell.user = self.userList[indexPath.row]

        return cell
    }
}

extension UserCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //ユーザーデータを取り出す
        let userData : UserData = self.userList[indexPath.row]

        //UserDetailViewのインスタンスを作る
        let detail = UserDetailViewController()
        
        //deteilの変数にユーザーデータを入れる
        detail.userData = userData
        
        //画面遷移
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
}
