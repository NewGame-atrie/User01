//
//  UserDetailViewController.swift
//  User01
//
//  Created by 北田菜穂 on 2020/10/09.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//


import UIKit
import WebKit

class UserDetailViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    var userData : UserData? = nil
    var webView : WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = self.userData?.name
        
        let conf = WKWebViewConfiguration()
        
        self.webView = WKWebView(frame: self.view.bounds, configuration: conf)
        
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        
        self.view.addSubview(self.webView)
        
        if let safeUrlString = self.userData?.url, let urlObj = URL(string: safeUrlString) {
            let req : URLRequest = URLRequest(url: urlObj)
            self.webView.load(req)
        }
    }
}
