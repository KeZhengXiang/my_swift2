//
//  MyScrollView.swift
//  newTest
//
//  Created by one on 2020/6/28.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit
import Kingfisher
import MJRefresh

//https://developer.apple.com/documentation/uikit/uiscrollview
//https://developer.apple.com/documentation/uikit/uiscrollviewdelegate
class MyScrollView : BaseViewController {
    
    var model :ModelTest?
    var scrollView :UIScrollView!
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createrUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    func createrUI() -> Void {
//        let width :CGFloat = kScreenW - 100
//        let height :CGFloat = kScreenH + 500
        let initRect = CGRect(x: 0, y: kNavigationBarHeight, width: kScreenW - 100, height: kScreenH - kNavigationBarHeight - kBottomSafeHeight)
        
        self.scrollView = UIScrollView(frame: initRect)
        
        self.view.addSubview(scrollView)
        self.scrollView.delegate = self
        self.scrollView.backgroundColor = UIColor.green
        
        //滑动区域大小（内容区域）
        self.scrollView.contentSize = CGSize(width: initRect.size.width, height: initRect.size.height)
        
        var _h :CGFloat = 0
        for i in 0...20 {
            let label = UILabel(frame: CGRect(x: 0, y: _h, width: initRect.size.width, height: 60))
            //添加事件
            let tap = UITapGestureRecognizer(target:self, action:#selector(tapClick))
            label.isUserInteractionEnabled = true//设置view可以点击
            label.addGestureRecognizer(tap)
            
            label.text = "item\(i)"
            label.backgroundColor = UIColor.red
            label.textAlignment = .center
            self.scrollView.addSubview(label)
            _h+=60
        }
        //更新内容区域
        self.scrollView.contentSize = CGSize(width: initRect.size.width, height: initRect.size.height + (_h - initRect.size.height) )
        
        print("\(self.classForCoder)页面size:  \(view.bounds.size)")
        print("self.scrollView.frame:  \(self.scrollView.frame)")
        print("self.scrollView.contentSize:  \(self.scrollView.contentSize)")
        print("self.scrollView.contentInset = \(self.scrollView.contentInset)")
        
//        /*••••••••••••••••••••上拉加载•下拉刷新••••••••••••••••••••••*/
//        //自定义
//        self.scrollView.mj_header = RefreshView(refreshingBlock: {
//            [weak self] () -> Void in
//            self?.headerRefresh()
//        })
//        self.scrollView.mj_footer = LoadMoreView(refreshingBlock: {
//            [weak self] () -> Void in
//            self?.footerRefresh()
//        })
//        self.scrollView.mj_header?.beginRefreshing()
    }
    
    //下拉刷新数据（初始拉取数据）
    @objc func headerRefresh() {
        print(#function)
        self.scrollView.mj_footer?.resetNoMoreData()
        let param = ["s" : "api/test/list"];
        let url = "http://onapp.yahibo.top/public"
        HttpManager.shared.requestDatas(.get, URLString: url, paramaters: param, finishCallBack: {[weak self] (response) in
            guard self != nil else{
                self?.scrollView.mj_header?.endRefreshing()
                return
            }
            let jsonData = JSON(response)
            //print(jsonData["data"])
            if let object = ModelTest.deserialize(from: jsonData["data"].rawString()) {
                self?.model = object;
                
//                self?.scrollView.reloadData();
                self?.scrollView.mj_header?.endRefreshing()
            }
        }) {[weak self] (code) in
            self?.scrollView.mj_header?.endRefreshing()
        }
    }
    
    //上拉加载
    @objc func footerRefresh() {
        print(#function)
//        self.tableview.mj_footer?.endRefreshingWithNoMoreData()
//        self.tableview.mj_footer?.endRefreshing()
        self.scrollView.mj_footer?.resetNoMoreData()
        let param = ["s" : "api/test/list"];
        let url = "http://onapp.yahibo.top/public"
        HttpManager.shared.requestDatas(.get, URLString: url, paramaters: param, finishCallBack: {[weak self] (response) in
            guard self != nil else{
                self?.scrollView.mj_footer?.endRefreshing()
                self?.scrollView.mj_footer?.endRefreshingWithNoMoreData()
                return
            }
            let jsonData = JSON(response)
            //print(jsonData["data"])
            if let object = ModelTest.deserialize(from: jsonData["data"].rawString()) {
                self?.model!.list.append(contentsOf: object.list)
//                self?.scrollView.reloadData()
                self?.scrollView.mj_footer?.endRefreshing()
            }
        }) {[weak self] (code) in
            self?.scrollView.mj_footer?.endRefreshing()
            self?.scrollView.mj_footer?.endRefreshingWithNoMoreData()
        }
    }
    
    @objc func tapClick(gr :UITapGestureRecognizer){
        print(gr)
        print("self.scrollView.contentSize:  \(self.scrollView.contentSize)")
        print("self.scrollView.contentInset = \(self.scrollView.contentInset)")
//        self.scrollView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        self.scrollView.mj_footer?.endRefreshing()
    }
}


extension MyScrollView : UIScrollViewDelegate {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 向下拉动偏移量大于等于20
        if scrollView.contentOffset.y  >= -20 {
            print("now is \(scrollView.contentOffset.y)")
        }
    }
}
