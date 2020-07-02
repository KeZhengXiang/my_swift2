//
//  DBSHHelper.swift
//  newTest
//
//  Created by one on 2020/6/30.
//  Copyright © 2020 one. All rights reserved.
//

import Foundation
import SQLite

//用户数据模型，简单定义了属性、初始化方法及数据存储实现。
struct DBHistorysModel {

    var id: Int = 0//数据库自增
    
    var name: String = ""
    var historys :Array<String> = []
    var icon: UIImage = UIImage.init()

    init() {}

    init(name: String, historys :Array<String>, icon: UIImage) {
        self.name = name
        self.historys = historys
        self.icon = icon
    }
}

/**************************************************************************/
///一个实现DBProtocol的class，完成具体的数据操作
class DBSHHelper: DBSHProtocl {
    
    //Type
    typealias T = DBHistorysModel
    typealias KEY = String
    
    // tabel
    static let TABLE_NAME = "historys"
    static let table = Table(TABLE_NAME)
    
    
    // model
    static let id = Expression<Int>("id")//Int
    static let name = Expression<String>("name")//String
    static let historys = Expression<Blob>("historys")// 数组编码
    static let icon = Expression<UIImage>("icon")//UIImage

    
    ///创建表
    static func createTable() throws {
        guard let DB = DBManager.shared.DB else {
            throw DataAccessError.datastoreConnectionError
        }
        do {
            _ = try DB.run(table.create(ifNotExists: true){t in
                t.column(id, primaryKey: PrimaryKey.autoincrement)//自增加
                t.column(name)
                t.column(historys)
                t.column(icon)
            })
        }catch _ {
            throw DataAccessError.datastoreConnectionError
        }
    }
    
    //表长度
    static var count = {
        return table.count
    }()

    ///插入item
    @discardableResult static func insert(item: T) throws -> Int {

        guard let DB = DBManager.shared.DB else {
            throw DataAccessError.datastoreConnectionError
        }

        //编码至二进制
        let blob :Blob = kgetHBlob(item.historys)

        let insert = table.insert(name <- item.name, historys <- blob , icon <- item.icon)
        do {
            let rowId = try DB.run(insert)
            guard rowId >= 0 else {
                throw DataAccessError.insertError
            }
            return Int(rowId)
        }catch _ {
            throw DataAccessError.insertError
        }
    }

    ///更新item
    @discardableResult static func update(item: T) throws -> Bool {

        guard let DB = DBManager.shared.DB else {
            throw DataAccessError.datastoreConnectionError
        }
        
        let query = table.filter(item.name == name)

        //编码至二进制
        let blob :Blob = kgetHBlob(item.historys)
        if try DB.run(query.update(name <- item.name, historys <- blob , icon <- item.icon)) > 0 {
            return true
        }else{
            return false
        }

    }

    ///检测是否存在
    @discardableResult static func checkColimnExists(ID: Int) throws -> Bool {

        guard let DB = DBManager.shared.DB else {
            throw DataAccessError.datastoreConnectionError
        }

        let query = table.filter(id == ID).exists

        let isExists = try DB.scalar(query)
        return isExists

    }

    ///删除item
    @discardableResult static func delete(item: T) throws -> Bool {

        guard let DB = DBManager.shared.DB else {
            throw DataAccessError.datastoreConnectionError
        }
        let query = table.filter(item.name == name)
        do {
            let tmp = try DB.run(query.delete())

            guard tmp == 1 else {
                throw DataAccessError.deleteError
            }
        }catch _ {
            throw DataAccessError.deleteError
        }
        return true
    }

    //查询
    @discardableResult static func find(key: KEY) throws -> [DBHistorysModel] {

        guard let DB = DBManager.shared.DB else {
            throw DataAccessError.datastoreConnectionError
        }

        let query = table.filter(name == key)
        let items = try DB.prepare(query)
        var retArray = [T]()
        for item in items {
            //解码
            let arr = kgetHarr(item[historys])
            retArray.append(DBHistorysModel(name: item[name], historys: arr, icon: item[icon]))
            
        }
        return retArray
    }
}


///工具方法
extension DBSHHelper {
    
    ///编码数组至二进制
    static func kgetHBlob(_ historys :[String]) ->Blob{
        let data :Data = try! NSKeyedArchiver.archivedData(withRootObject: historys, requiringSecureCoding: true)
        let blob :Blob = (data as NSData).datatypeValue
        return blob
    }
    ///解码二进制至数组
    static func kgetHarr(_ blob :Blob) ->[String]{
        let data :Data = NSData.fromDatatypeValue(blob) as Data
        //解码
        if let arr: [String] = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] {
            print("\(#function)-编码范例: \(arr)")
            return arr
        }
        return []
    }
}
