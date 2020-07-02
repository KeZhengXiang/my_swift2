//
//  MyDataBase.swift
//  newTest
//
//  Created by one on 2020/6/29.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit

import SQLite3
import SQLite
//1、SQLite数据库  pod 'SQLite.swift'  https://www.jianshu.com/p/30e31282c4b9
//https://www.jianshu.com/p/61b3bdc873b0

class MyDBVC :UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "数据库应用"
        view.backgroundColor = UIColor.systemYellow
        
        PathManager.shared.printPath()
        
        //开启数据库
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //关闭数据库
    }
    
    /*创建数据库*/
    func createDB(){
        //获取doc路径
        let path = PathManager.shared.pDocuments()
        //如果不存在的话，创建一个名为db.sqlite3的数据库，并且连接数据库
        guard let db = try? Connection("\(path)/db.sqlite3") else {
            return
        }
        db.busyTimeout = 5//超时时间(秒)
        db.busyHandler({ tries in
            if tries >= 3 {
                return false
            }
            return true
        })
    }
    
    
}


//MARK
extension MyDBVC {
    
    func creatDB()  {
        do {
            try DataBaseManager.shared.createTables()
        }catch _ {
            print("create DB error")
        }
    }
    
    func insertUserModel()  {
        
        let userModel = DBUserInfoModel(userId: 100, name: "liugaojian", icon: UIImage.init(named: "default")!)
        do {
           let torId = try DBHelper.insert(item: userModel)
            print(torId)
        } catch _ {
            print("insert userModel error")
        }
        
    }
    
    func checkUserModel() {
        do {
            let exists =  try DBHelper.checkColimnExists(queryUserId: 100)
            print(exists)
        } catch _ {
            print("check userModel error")
        }
    }
    
    func updateUserModel()  {
        
        let userModel = DBUserInfoModel(userId: 100, name: "guhongjuan", icon: UIImage.init(named: "local")!)
        do {
            let isSuccess =  try DBHelper.update(item: userModel)
            print(isSuccess)
        } catch _ {
                print("update userModel error")
        }
    }
    
    func getUserModel()  {
        do {
            let items = try DBHelper.find(queryUserId: 100)
            
            if let item = items.first {
                print(item.userId, item.name, item.icon)
            }
            
        } catch _ {
            print("get userModel error")
        }
    }
    
    func getAllUserModel()  {
        
        do {
            let items =  try DBHelper.findAll()!
            for item: DBUserInfoModel in items {
                print(item.userId, item.name, item.icon)
            }
        } catch _ {
            print("find userModel error")
        }
    }
}
