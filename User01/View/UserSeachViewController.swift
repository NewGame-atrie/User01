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

    private var searchController : UISearchController!
    private var resultsViewController : ResultsViewController!
    
    var searchRepository : UserSearchRepository = UserSearchRepository()

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
        
        self.searchRepository.delegate = self
    }

    // MARK: Private Methods

    //検索バーのセットアップ
    private func setupSearch() {
        
        //履歴機能のインタレスト作る
        self.resultsViewController = ResultsViewController()
        
        //UISearchControllerの作成
        searchController = UISearchController(searchResultsController: self.resultsViewController)
        searchController.searchResultsUpdater = self.resultsViewController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        // UISearchControllerをUINavigationItemのsearchControllerプロパティにセットする。
        navigationItem.searchController = searchController

        // trueだとスクロールした時にSearchBarを隠す（デフォルトはtrue）
        // falseだとスクロール位置に関係なく常にSearchBarが表示される
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    //検索ワードを履歴機能に保存
    func saveSearchWord(_ text: String){
        
        let userDefaults = UserDefaults.standard
        
        if var histories = userDefaults.array(forKey: "Histories") as? [String] {
            histories.append(text)
            userDefaults.setValue(histories, forKey: "Histories")
        }else{
            userDefaults.setValue([text], forKey: "Histories")
        }
        
        userDefaults.synchronize()
        
    }
    
    //履歴の再更新
    //新しいワードを昇順にする
    func loadSearchHistory(){
        let userDefaults = UserDefaults.standard
        
        if let histories = userDefaults.array(forKey: "Histories") as? [String] {
            self.resultsViewController.dummyItems = histories.reversed()
        }
    }
    
}


// MARK: - UISearchBarDelegate
extension UserSearchViewController: UISearchBarDelegate {
    
    //検索バーにカーソルを置くと履歴機能を表示
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.loadSearchHistory()
        self.searchController.showsSearchResultsController = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //検索ボタンが押された時にここが呼ばれます
        //検索ワード
        guard let searchText : String = searchBar.text else {
            return
        }
        self.searchRepository.search(searchText)
        
        self.searchController.isActive = false
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
        
        //検索履歴のユーザー名を表示
        if let name = userData.name {
            self.saveSearchWord(name)
        }
        
        //画面遷移
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
}

// MARK: - UserSearchRepositoryDelegate
extension UserSearchViewController: UserSearchRepositoryDelegate {
   
    func onSearchFinish(_ data: [String : Any]) {
        
        guard let items = data["items"] as? [[String:Any]] else {
            return
        }
        
        var result : [UserData] = []
        
        for i in items {
            let user = UserData.convert(i)
            result.append(user)
        }
        
        self.userList = result
        
        //reload tableview
        self.tableView.reloadData()
        
        // ０件の時にアラートを出す
        if self.userList.count < 1 {
            self.showAlert("検索結果は、0件です")
        }
    }
    
    func onSearchError(_ error: Error) {
        self.showAlert("通信エラー")
    }
    
    func showAlert(_ message : String){
        let alert: UIAlertController = UIAlertController(title: "エラー", message: message, preferredStyle:  UIAlertController.Style.alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler:{
            // キャンセルボタンが押された時の処理をクロージャ実装する
            (action: UIAlertAction!) -> Void in
        })
        //UIAlertControllerにキャンセルボタンを追加
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UserSearchViewController: ResultsViewControllerDelegate {
    func onSelectItem(_ vc: ResultsViewController, item: String){}
}
