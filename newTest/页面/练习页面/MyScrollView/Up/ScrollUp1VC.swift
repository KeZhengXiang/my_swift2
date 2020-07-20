//
//  ScrollUp1VC.swift
//  newTest
//
//  Created by one on 2020/7/19.
//  Copyright © 2020 one. All rights reserved.
//  参考: https://www.hangge.com/blog/cache/detail_2271.html

import Foundation

import UIKit
 
class ScrollUp1VC: BaseViewController {
     
    let screenWidth = UIScreen.main.bounds.width // 屏幕宽度
    let screenHeight = UIScreen.main.bounds.height  // 屏幕高度
     
    var imageView: UIImageView! // 图片视图
    let imageViewHeight: CGFloat = 200 // 图片默认高度
     
    var tableView: UITableView! //表格视图
    let rowNumber = 50 // 表格数据条目数
    let rowHeight: CGFloat = 40 // 表格行高
    
    //导航栏背景视图
    var barImageView: UIView?
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
//        isNavSpecialHidden = true
        
        //获取导航栏背景视图
        self.barImageView = self.navigationController?.navigationBar.subviews.first
        //修改导航栏背景色
//        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = .orange
         
        // 首先创建一个滚动视图，图片还是tableView都放在这个滚动视图中
        let scrollView = UIScrollView()
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSize(width: screenWidth,
                            height: CGFloat(rowNumber) * rowHeight + imageViewHeight)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        self.view.addSubview(scrollView)
         
        // 初始化图片视图
        self.imageView = UIImageView()
        self.imageView.frame = CGRect(x: 0, y: 0, width: screenWidth,
                                      height: imageViewHeight)
        self.imageView.image = UIImage(named: "navbar_bg_normal")
        self.imageView.contentMode = .scaleAspectFill
        scrollView.addSubview(self.imageView)
         
        //创建表视图
        self.tableView = UITableView(frame: CGRect(x: 0, y: imageViewHeight,
                width: screenWidth, height: CGFloat(rowNumber) * rowHeight), style:.plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = CGFloat(rowHeight)
        self.tableView.isScrollEnabled = false
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "SwiftCell")
        scrollView.addSubview(self.tableView!)
        
        print(CGFloat.maximum(-1, 0))
        print(CGFloat.maximum(1, 0))
        print(CGFloat.maximum(22, 1))
        print(CGFloat.maximum(-1, -2))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 默认情况下导航栏全透明
        self.barImageView?.alpha = 0
    }
}
 
extension ScrollUp1VC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取偏移量
        let offset = scrollView.contentOffset.y
        // 改变图片大小
        if offset <= 0 {
            self.imageView.frame = CGRect(x: 0, y: offset, width: screenWidth,
                                          height: imageViewHeight - offset)
        }
        
        // 导航栏背景透明度改变
        var delta =  offset / (imageViewHeight - kNavigationBarHeight)
        delta = CGFloat.maximum(delta, 0)//选择最大值
        self.barImageView?.alpha = CGFloat.minimum(delta, 1)
        print("delta = \(delta), alpha = \(CGFloat.minimum(delta, 1))")
         
        // 根据偏移量决定是否显示导航栏标题（上方图片快完全移出时才显示）
        self.title =  delta > 0.9 ? "滑动隐藏导航栏" : ""
    }
}
 
extension ScrollUp1VC: UITableViewDelegate, UITableViewDataSource {
    //在本例中，有1个分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     
    //返回表格行数（也就是返回控件数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
        return rowNumber
    }
     
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "SwiftCell"
            //同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCell(
                withIdentifier: identify, for: indexPath)
            cell.textLabel?.text = "数据条目：\(indexPath.row + 1)"
            return cell
    }
}
