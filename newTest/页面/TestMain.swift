//
//  TestMain.swift
//  newTest
//
//  Created by one on 2020/6/27.
//  Copyright © 2020 one. All rights reserved.
//
//
import UIKit
import SnapKit


class TestMain : UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var lists :Array<UIViewController> = []
    let listNames :Array<String> = [
        "设备信息 监听设备 MyDevice",
        "生命周期 LifeVC",
        "安全区域-刘海屏 MySafeAreaInsets",
        "导航栏 NavigationVC",
        "滑动容器 MyScrollView",
        "列表 MyTableView",
        "网格 MyCollectionView",
        "网格-瀑布流 CustomCollectionView",
        "动画 MyAnimation",
        "搜索 MySearch",
        "数据库 SQLite",
        "七种手势 MyGestrue",
        "绘制 MyCoreGraphics",
        "page MyPageViewController"]
    
    var tableview :UITableView!
    
    func getVC(index :Int) -> UIViewController {
        switch index {
        case 0: return MyDevice()
        case 1: return LifeVC()
        case 2: return MySafeAreaInsets()
        case 3: return NavigationVC()
        case 4: return MyScrollView()
        case 5: return MyTableView()
        case 6: return MyCollectionView()
        case 7: return CustomCollectionView()
        case 8: return MyAnimation()
        case 9: return MySearch()
        case 10:return MyDBVC()
        case 11:return MyGestrue()
        case 12:return MyCoreGraphics()
        case 13:return MyPageViewController()
        default:
            return UIViewController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview = UITableView.init(frame: self.view.frame, style: .plain)
        
        self.view.addSubview(tableview)
        //注册
        tableview.register(MyTestCell.self, forCellReuseIdentifier: "MyTestCell")
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
    }
    
    //分区数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    //每个分区行数（默认分区为一个）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNames.count ;
    }
    
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTestCell(style: .subtitle, reuseIdentifier: "MyTestCell")
        cell.selectionStyle = .blue
        cell.createUI(name: listNames[indexPath.row])
        return cell
    }
    
    //行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    //cell点击事件处理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt \(indexPath)")
        
        let anotherVC = getVC(index:Int(indexPath.row))
        self.navigationController?.pushViewController(anotherVC, animated: true)
    }
    
}



class MyTestCell: UITableViewCell {
    
    
    var label :UILabel!
    
    func createUI(name :String){
        label = UILabel()
        label.text = name
//        label.backgroundColor = UIColor.red
//
//        contentView.backgroundColor = UIColor.green
//
        label.frame = CGRect(x: 0, y: 0, width: kScreenW, height: self.frame.size.height)
        label.textAlignment = .center
        
        contentView.addSubview(label)
    }
}
