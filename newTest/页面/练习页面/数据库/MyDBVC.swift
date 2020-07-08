//
//  MyDataBase.swift
//  newTest
//
//  Created by one on 2020/6/29.
//  Copyright © 2020 one. All rights reserved.
//
//import Foundation
import UIKit

import SQLite
//1、SQLite数据库  pod 'SQLite.swift'
//https://www.jianshu.com/p/30e31282c4b9  全面知识
//https://www.jianshu.com/p/61b3bdc873b0    封装试例


class MyDBVC :UIViewController {
    let _item = DBHistorysModel(name: "道长生", historys: ["你好","123","abc"], icon: UIImage(named: "backImage0")!)
    
    var _h :CGFloat = 150
    
    //******插入数据
    lazy var insertBtn :UIButton = {
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: _h, width: 200, height: 30)
        _h+=40
        button.setTitle("插入数据", for: .normal)
        button.backgroundColor = UIColor.green
        button.addTarget(self,action:#selector(insertClick),for:.touchUpInside)
        return button
    }()
    @objc func insertClick(){
        print("count = \(DBSHHelper.count)")
        do {
            try DBSHHelper.insert(item: _item)
        }catch _{
        }
    }
    //********更新数据*******
    lazy var updateBtn :UIButton = {
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: _h, width: 200, height: 30)
        _h+=40
        button.setTitle("更新数据", for: .normal)
        button.backgroundColor = UIColor.green
        button.addTarget(self,action:#selector(updateClick),for:.touchUpInside)
        return button
    }()
    @objc func updateClick(){
        do {
            try DBSHHelper.update(item: _item)
        }catch _{
        }
    }
    //*******删除数据********
    lazy var deleteBtn :UIButton = {
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: _h, width: 200, height: 30)
        _h+=40
        button.setTitle("删除数据", for: .normal)
        button.backgroundColor = UIColor.green
        button.addTarget(self,action:#selector(deleteClick),for:.touchUpInside)
        return button
    }()
    @objc func deleteClick(){
        do {
            try DBSHHelper.delete(item: _item)
        }catch _{
        }
    }
    //*******查询数据********
    lazy var findBtn :UIButton = {
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: _h, width: 200, height: 30)
        _h+=40
        button.setTitle("查询数据", for: .normal)
        button.backgroundColor = UIColor.green
        button.addTarget(self,action:#selector(findClick),for:.touchUpInside)
        return button
    }()
    @objc func findClick(){
        do {
            let arr :[DBHistorysModel] = try DBSHHelper.find(key: "道长生")
            print("find: \(arr)")
        }catch _{
        }
    }
    
    //*******位图数据********
    lazy var imageV :UIImageView = {
        let imgv = UIImageView(frame: CGRect(x: 100, y: _h, width: 1080 / 4, height: 1920/4))
        _h+=1920/4
        return imgv
    }()
    lazy var imageBtn :UIButton = {
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: _h, width: 200, height: 30)
        _h+=40
        button.setTitle("有则显示位图", for: .normal)
        button.backgroundColor = UIColor.green
        button.addTarget(self,action:#selector(imgClick),for:.touchUpInside)
        return button
    }()
    @objc func imgClick(){
        do {
            if let model :DBHistorysModel = try DBSHHelper.find(key: "道长生").first {
                imageV.image = model.icon
            }else{
                imageV.image = nil
                imageV.backgroundColor = UIColor.gray
            }
        }catch _{
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "数据库应用"
        view.backgroundColor = UIColor.systemYellow
        
//        PathManager.shared.printPath()
        
        //连接数据库
//        ConnectionDB()
        do {
            try DBSHHelper.createTable()
        }catch _{
            
        }
        
        self.view.addSubview(insertBtn)
        self.view.addSubview(updateBtn)
        self.view.addSubview(deleteBtn)
        self.view.addSubview(findBtn)
        self.view.addSubview(imageBtn)
        self.view.addSubview(imageV)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
//
//    /*连接数据库*/
//    func ConnectionDB(){
//        let dbName :String = "db.sqlite3"
//        //获取doc路径
//        let path = PathManager.shared.pDocuments()
//        print(path)
//        //如果不存在的话，创建一个名为db.sqlite3的数据库，并且连接数据库
//        guard let db = try? Connection("\(path)/\(dbName)") else {
//            return
//        }
//        db.busyTimeout = 5//超时时间(秒)
//        db.busyHandler({ tries in
//            if tries >= 3 {
//                return false
//            }
//            return true
//        })
//
//        //创建表 table
//        let userId = Expression<Int>("userId")
//        let name = Expression<String>("name")
//        let icon = Expression<UIImage>("icon")
//        do {
//            let table = Table("tableTest",database: dbName)
//            try db.run(table.create(ifNotExists: true){ t in
//                t.column(userId)
//                t.column(name)
//                t.column(icon)
//            })
//        }catch (let err) {
//            print(err)
//        }
//    }
    
    
    
}

//
////MARK
//extension MyDBVC {
//
////    func creatDB()  {
////        do {
////            try DBManager.shared.createTables()
////        }catch _ {
////            print("create DB error")
////        }
////    }
//
//    func insertUserModel()  {
//
//        let userModel = DBUserInfoModel(userId: 100, name: "liugaojian", icon: UIImage.init(named: "default")!)
//        do {
//           let torId = try DBHelper.insert(item: userModel)
//            print(torId)
//        } catch _ {
//            print("insert userModel error")
//        }
//
//    }
//
//    func checkUserModel() {
//        do {
//            let exists =  try DBHelper.checkColimnExists(queryUserId: 100)
//            print(exists)
//        } catch _ {
//            print("check userModel error")
//        }
//    }
//
//    func updateUserModel()  {
//
//        let userModel = DBUserInfoModel(userId: 100, name: "guhongjuan", icon: UIImage.init(named: "local")!)
//        do {
//            let isSuccess =  try DBHelper.update(item: userModel)
//            print(isSuccess)
//        } catch _ {
//                print("update userModel error")
//        }
//    }
//
//    func getUserModel()  {
//        do {
//            let items = try DBHelper.find(queryUserId: 100)
//
//            if let item = items.first {
//                print(item.userId, item.name, item.icon)
//            }
//
//        } catch _ {
//            print("get userModel error")
//        }
//    }
//
//    func getAllUserModel()  {
//
//        do {
//            let items =  try DBHelper.findAll()!
//            for item: DBUserInfoModel in items {
//                print(item.userId, item.name, item.icon)
//            }
//        } catch _ {
//            print("find userModel error")
//        }
//    }
//}
