//
//  MyWebViewVC.swift
//  newTest
//
//  Created by one on 2020/7/13.
//  Copyright © 2020 one. All rights reserved.
//


import UIKit
import WebKit


class MyWebViewVC: BaseViewController {
    
    
    //视图加载完成
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "嵌入网页 WebView"
        view.backgroundColor = UIColor.systemYellow
        
        // 创建 WKWebView 视图
        let myWebView = WKWebView(frame: self.view.bounds)
        // 创建网页 URL
        let url = URL(string: "https://www.hangge.com/blog/cache/detail_1319.html")
        // 创建请求
        let req = URLRequest(url: url!)
        // 加载网页
        myWebView.load(req)
        self.view.addSubview(myWebView)
        
    }
    
    //视图将要出现的时候执行
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}
