//
//  ResultsViewController.swift
//  User01
//
//  Created by 北田菜穂 on 2020/12/14.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import UIKit

//履歴機能のデリゲート
protocol ResultsViewControllerDelegate : class {
    func onSelectItem( _ vc : ResultsViewController, item : String)
}

//履歴機能の実装
class ResultsViewController : UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
        
    weak var resultsViewControllerDelegate : ResultsViewControllerDelegate? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = filteredItems[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        self.resultsViewControllerDelegate?.onSelectItem(self, item: filteredItems[indexPath.row])
        
    }
    
    var dummyItems : [String] = []  {
        didSet {
            self.filteredItems = dummyItems
        }
    }
    var tableView: UITableView!
    
    var filteredItems : [String] = []
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            print("text=\(text)")
            
            self.filteredItems = dummyItems.filter({ $0.lowercased().starts(with: text.lowercased())})
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        
        //TableViewのセットアップ
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
}
