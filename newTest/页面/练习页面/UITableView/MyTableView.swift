//
//  MyTableView.swift
//  newTest
//
//  Created by one on 2020/6/20.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit
import Kingfisher
import MJRefresh


class MyTableView : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model :ModelTest?
    var tableview :UITableView!
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createrUI()
    }
    
    
    func createrUI() -> Void {
        
        self.tableview = UITableView.init(frame: self.view.frame, style: .plain)
        
        self.view.addSubview(tableview)
        //注册
        tableview.register(MyTableCell.self, forCellReuseIdentifier: "cell")
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        
        /*••••••••••••••••••••上拉加载•下拉刷新••••••••••••••••••••••*/
        
        // 下拉刷新
//        header.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefresh))
//        // 现在的版本要用mj_header
//        self.tableview.mj_header = header
//
//        // 上拉刷新
//        footer.setRefreshingTarget(self, refreshingAction: #selector(self.footerRefresh))
//        self.tableview.mj_footer = footer
        //自定义
        self.tableview.mj_header = RefreshView(refreshingBlock: {
            [weak self] () -> Void in
            self?.headerRefresh()
        })
        self.tableview.mj_footer = LoadMoreView(refreshingBlock: {
            [weak self] () -> Void in
            self?.footerRefresh()
        })
        self.tableview.mj_header?.beginRefreshing()
    }
    
    //下拉刷新数据（初始拉取数据）
    @objc func headerRefresh() {
        print(#function)
        self.tableview.mj_footer?.resetNoMoreData()
        
        let param = ["s" : "api/test/list"];
        let url = "http://onapp.yahibo.top/public"
        HttpManager.shared.requestDatas(.get, URLString: url, paramaters: param, finishCallBack: {[weak self] (response) in
            guard self != nil else{
                self?.tableview.mj_header?.endRefreshing()
                return
            }
            let jsonData = JSON(response)
            //print(jsonData["data"])
            if let object = ModelTest.deserialize(from: jsonData["data"].rawString()) {
                self?.model = object;
                self?.tableview.reloadData();
                self?.tableview.mj_header?.endRefreshing()
            }
        }) {[weak self] (code) in
            self?.tableview.mj_header?.endRefreshing()
        }
    }
    
    //上拉加载
    @objc func footerRefresh() {
        print(#function)
//        self.tableview.mj_footer?.endRefreshingWithNoMoreData()
//        self.tableview.mj_footer?.endRefreshing()
        let param = ["s" : "api/test/list"];
        let url = "http://onapp.yahibo.top/public"
        HttpManager.shared.requestDatas(.get, URLString: url, paramaters: param, finishCallBack: {[weak self] (response) in
            guard self != nil else{
                self?.tableview.mj_footer?.endRefreshing()
                self?.tableview.mj_footer?.endRefreshingWithNoMoreData()
                return
            }
            let jsonData = JSON(response)
            //print(jsonData["data"])
            if let object = ModelTest.deserialize(from: jsonData["data"].rawString()) {
                self?.model!.list.append(contentsOf: object.list)
                self?.tableview.reloadData()
                self?.tableview.mj_footer?.endRefreshing()
                self?.tableview.mj_footer?.endRefreshingWithNoMoreData()
            }
        }) {[weak self] (code) in
            self?.tableview.mj_footer?.endRefreshing()
            self?.tableview.mj_footer?.endRefreshingWithNoMoreData()
        }
    }
    //分区数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    //每个分区行数（默认分区为一个）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.list.count ?? 0;
    }
    
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTableCell(style: .subtitle, reuseIdentifier: "--cell1--")
        cell.selectionStyle = .blue
        cell.model = model?.list[indexPath.row]
        cell.textLabel?.text = cell.model?.name;
        cell.createrUI();
        return cell
        
    }
    
    //行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    //cell点击事件处理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt \(indexPath)")
        headerRefresh()
    }
    
    //是否可编辑？
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        var action1:UITableViewRowAction
        var action2:UITableViewRowAction
        //TODO:以下是添加两个按钮在cell上
        action1 = UITableViewRowAction.init(style: .default, title: "删除", handler: { (Taction, index) in
            
//            print("删除操作  index =\(index)  indexPath = \(indexPath)")
            self.model!.list.remove(at: indexPath.row)
            self.tableview.deleteRows(at:[indexPath], with: UITableView.RowAnimation.left)
        })
        action2 = UITableViewRowAction.init(style:.normal, title: "复制", handler: { (Taction, index) in
            self.model!.list.insert(self.model!.list[index.row], at: index.row)
            self.tableview.insertRows(at:[indexPath], with: UITableView.RowAnimation.right)
//            print("复制操作  index =\(index)  indexPath = \(indexPath)")
        })
        return [action1,action2]
    }
}



class MyTableCell: UITableViewCell {
    
    var model :ModelTestCell?
    
    var imageV :UIImageView!
    var label1 :UILabel!
    var label2 :UILabel!
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        print("init cell : \(model?.name ?? "0")")
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    deinit {
//        print("deinit cell : \(model?.name ?? "0")")
//    }
    
    func createrUI(){
        /*****************从网络地址获取图片*******************/
        //定义URL对象
        let url = URL(string: model?.headimg ?? "http://hangge.com/blog/images/logo.png")
        //从网络获取数据流
//        let data = try! Data(contentsOf: url!)
//        //通过数据流初始化图片
//        imageV = UIImageView(image:UIImage(data: data));
        imageV = UIImageView();
        imageV.kf.setImage(with: url)
        self.addSubview(imageV)
        
        imageV.snp.makeConstraints { (make) in
            make.size.equalTo(70)
            make.centerY.equalToSuperview()
            make.left.equalTo(16)
        }
        
        let txth = heightOfCell(text: "s", fontSize: 16, width: 100)
        label1 = UILabel();
        addSubview(label1)
        label1.text = model?.name
//        label1.backgroundColor = UIColor.red
        label1.font = UIFont.systemFont(ofSize: 16)
        
        label1.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenW - (16 * 2 + 10 + 70))
            make.centerY.equalToSuperview().offset(-5 - txth/2)
            make.left.equalToSuperview().offset(16 + 70 + 10)
        }
        
        label2 = UILabel();
        addSubview(label2)
        label2.text = "简介：\(model!.description!)"
//        label2.backgroundColor = UIColor.red
        label2.font = UIFont.systemFont(ofSize: 16)
        label2.textColor = UIColor.gray
        label2.lineBreakMode = .byTruncatingTail
        label2.snp.makeConstraints { (make) in
            make.width.equalTo(kScreenW - (16 * 2 + 10 + 70))
            make.centerY.equalToSuperview().offset(5 + txth/2)
            make.left.equalTo(label1)
        }
        
//        let v = UIView()
//        v.backgroundColor = UIColor.green
//        addSubview(v)
//        v.snp.makeConstraints { (make) in            make.centerY.equalToSuperview().offset(-0.5)
//            make.width.equalTo(kScreenW)
//            make.height.equalTo(1)
//        }
    }
}
