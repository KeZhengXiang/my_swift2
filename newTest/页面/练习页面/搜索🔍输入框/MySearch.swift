//
//  MySearch.swift
//  newTest
//
//  Created by one on 2020/6/28.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit
import SnapKit
//https://developer.apple.com/documentation/uikit/uisearchbar
//https://developer.apple.com/documentation/uikit/uisearchbardelegate
//UISearchBar的使用一:把UISearchBar上英文Cancel变成中文 https://www.jianshu.com/p/80a848b78957
class MySearch: UIViewController {
    //需要存储本地   （后续添加）
    //显示限制条数
    let count = 2
    //历史记录  ["成都","重庆","上海","广州","珠海"]
    var historys: Array<String> = []
    
    //累加Y高度  初始绕过状态高度
    var _h :CGFloat = kStatusBarHeight
    
    let cellH :CGFloat = 50
    
    lazy var searchBar :UISearchBar = {
        let searchbar = UISearchBar(frame: CGRect(x: 0, y: _h, width: kScreenW, height: 60))
        _h += 60
        searchbar.delegate = self
        
        searchbar.backgroundColor = UIColor.clear
                
        searchbar.barStyle = UIBarStyle.black
        searchbar.barTintColor = UIColor.clear//搜索栏背景的色彩颜色。
                
        searchbar.placeholder = "搜索"
        searchbar.tintColor = UIColor.red
        searchbar.searchBarStyle = UISearchBar.Style.minimal
                
        // 注意：showsBookmarkButton、showsSearchResultsButton不能同时设置
        searchbar.showsCancelButton = true
//        searchbar.showsBookmarkButton = true
//         searchbar.showsSearchResultsButton = true
                
                
        // 键盘类型设置
        searchbar.keyboardType = UIKeyboardType.webSearch
        searchbar.returnKeyType = UIReturnKeyType.done
        searchbar.isSecureTextEntry = false//是否是安全键盘  默认false -
                
        // 输入源设置（与textfiele、或textview类似）
        // searchbar.inputAccessoryView = nil
        // searchbar.inputView = nil
                
                
        // 第一响应，即进入编辑状态
        searchbar.becomeFirstResponder()
        // 放弃第一响应，即结束编辑
        // searchbar.resignFirstResponder()
        // searchbar.endEditing(true) // 结束编辑
        return searchbar
    }()
    //历史记录列表
    lazy var tabView :UITableView = {
        let _tableview = UITableView(frame:CGRect(x: 0, y: _h, width: kScreenW, height: 0), style: .plain)
        _tableview.backgroundColor = UIColor.clear
        //注册
        _tableview.register(MyTableCell.self, forCellReuseIdentifier: "cell")
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
        _tableview.isScrollEnabled = false
        return _tableview
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "搜索  文本输入框"
        view.backgroundColor = UIColor.black
        
        //
        view.addSubview(searchBar)
        view.addSubview(tabView)
        
        //读取数据库
        findDB()
        
        updateTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidDisappear (_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //存储数据到DB
        updateDB()
        
    }
    
    func updateTable(){
        let showCount :Int = count > self.historys.count ? self.historys.count : count
        print(tabView.safeAreaInsets)
//        tabView.Inse = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tabView.frame.size = CGSize(width: tabView.frame.size.width, height: cellH * CGFloat(showCount))
        
        tabView.reloadData()
    }
    func insert(){
        //["成都","重庆","上海","广州","珠海"]
    }
    func findDB(){
        if let model :DBHistorysModel = try? DBSHHelper.find(key: "历史记录").first {
            historys = model.historys
        }else{
            
        }
    }
    func updateDB(){
        do {
            let _item = DBHistorysModel(name: "历史记录", historys: historys, icon: UIImage(named: "5e9e6df83a2eb")!)
            try DBSHHelper.delete(item: _item)
        }catch _{
        }
        
        do {
            let _item = DBHistorysModel(name: "历史记录", historys: historys, icon: UIImage(named: "5e9e6df83a2eb")!)
            try DBSHHelper.insert(item: _item)
        }catch _{
        }
    }
}


extension MySearch : UITableViewDataSource, UITableViewDelegate, MySearchCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count > self.historys.count ? self.historys.count : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        cell.indexPath = indexPath
        cell.cellH = cellH
        cell.delegate = self
        cell.createUI()
        cell.label.text = historys[indexPath.row];
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellH
    }
    
    //删除历史记录
    func deleteItem(_ indexPath: IndexPath) {
        historys.remove(at: indexPath.row)
//        tabView.deleteRows(at:[indexPath], with: UITableView.RowAnimation.left)
        updateTable()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = historys[indexPath.row]
        searchBar.text = str
        searchBar(searchBar,textDidChange: str)
        searchBarSearchButtonClicked(searchBar)
    }
}

extension MySearch : UISearchBarDelegate {
    
    ///文字
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("更改搜索文本: \(searchText)")
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("文本改变的时候触发 text: \(text)")

        return true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("将要开始编辑")
        return true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("已经开始编辑")
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        print("将要结束编辑")
        return true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("已经结束编辑")
    }
    
    ///响应
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("点击了“取消”按钮")
        self.navigationController?.popViewController(animated: false)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("点击了“搜索”按钮")
        //收录搜索关键字
        if let str = searchBar.text {
            historys.insert(str, at: 0)
            self.tabView.reloadData()
        }
        searchBar.text = ""
        updateTable()
        
//        searchBar..becomeFirstResponder()//弹出键盘
//        searchBar.resignFirstResponder()//收起键盘
        
        //跳转
//        self.navigationController?.popViewController(animated: false)
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("点击了“书签”按钮")
    }
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        print("点击了“搜索结果列表”按钮")
    }
    
    ///响应范围按钮更改
    //该范围按钮选择已更改
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
}


class SearchTableViewCell : UITableViewCell {
    
    weak open var delegate: MySearchCellDelegate?
    
    var indexPath :IndexPath?
    var index :Int = 0
    var cellH :CGFloat = 0
    
    let iconW :CGFloat = 25
    
    lazy var label :UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.white
        return lb
    }()
    
    lazy var imagev :UIImageView = {
        let img = UIImageView(image: UIImage(named: "icHistory24x24"))
        return img
    }()
    
    lazy var btn :UIButton = {
        let _btn = UIButton()
        _btn.setImage(UIImage(named: "icHistoryBlackclose30Small12x12"), for: UIControl.State.normal)
        _btn.addTarget(self, action: #selector(click), for: UIControl.Event.touchUpInside)
        return _btn
    }()
    
    func createUI() {
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        addSubview(imagev)
        addSubview(label)
        addSubview(btn)
        imagev.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(iconW)
            make.centerY.equalToSuperview()
        }
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset((16 + iconW + 5))
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        btn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(iconW)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func click() {
        print(#function)
        if let _indexPath = indexPath {
            delegate?.deleteItem(_indexPath)
            print("删除：\(label.text!)")
        }
    }
}


public protocol MySearchCellDelegate : NSObjectProtocol {

    func deleteItem(_ indexPath: IndexPath)

}
