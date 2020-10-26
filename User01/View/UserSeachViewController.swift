//
//  UserSeachViewController.swift
//  User01
//
//  Created by 北田菜穂 on 2020/10/02.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class UserSearchViewController: UIViewController {

    var tableView: UITableView!

    private var searchController: UISearchController!

    //var userList : [[String:Any]] = []
    var userList : [UserData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "ユーザー検索"

        //TableViewのセットアップ
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        //cellの登録
        self.tableView.register(UserDataCell.self, forCellReuseIdentifier: "UserDataCell")
        
        setupSearch()
    }

    // MARK: Private Methods

    //検索バーのセットアップ
    private func setupSearch() {
        
        //UISearchControllerの作成
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        // UISearchControllerをUINavigationItemのsearchControllerプロパティにセットする。
        navigationItem.searchController = searchController

        // trueだとスクロールした時にSearchBarを隠す（デフォルトはtrue）
        // falseだとスクロール位置に関係なく常にSearchBarが表示される
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    //検索実行
    func search(_ query : String){
        
        
        
        let url = "https://api.github.com/search/users?q=\(query)"
        
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            
            .responseJSON { response in
                
                switch response.result{
                    case.success:
                    print("OK")
                    let data = response.value
                    print("JSON=\(data)")
                    break
                    
                    case let .failure(error):
                    print("エラー")
                    print(error)
                }
                debugPrint(response)
                if let value = response.value {
                    self.onSuccess(value)
                }
            }
    }
    
    //検索結果を受け取ってデータ更新する
    func onSuccess(_ value : Any){
        
        print(value)
        
        guard let value = value as? [String:Any],
              let items = value["items"] as? [[String:Any]] else {
            
            return
        }
        
        //var result : [[String:Any]] = []
        var result : [UserData] = []
        
        
        for i in items {
            let user = UserData.convert(i)
            result.append(user)
        }
        
        self.userList = result
        
        //reload tableview
        self.tableView.reloadData()
        
    }
}

// MARK: - UISearchResultsUpdating
extension UserSearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

// MARK: - UISearchResultsUpdating
extension UserSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //検索ボタンが押された時にここが呼ばれます
        
        //検索ワード
        guard let searchText : String = searchBar.text else {
            return
        }
        
        self.search(searchText)
        
    }
}

// MARK: - UITableViewDataSource
extension UserSearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UserDataCell = tableView.dequeueReusableCell(withIdentifier: "UserDataCell", for: indexPath) as! UserDataCell
        cell.user = self.userList[indexPath.row]
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension UserSearchViewController: UITableViewDelegate {
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
