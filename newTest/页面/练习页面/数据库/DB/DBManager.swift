//
//  DataBaseManager.swift
//  newTest
//
//  Created by one on 2020/6/29.
//  Copyright © 2020 one. All rights reserved.
//

import Foundation
import SQLite

enum DataAccessError: Swift.Error {
    case datastoreConnectionError//连接数据库错误
    case insertError
    case deleteError
    case searchError
    case nilInData
    case nomoreData
}

//数据库名称
let DBName :String = "myDB.sqlite"

class DBManager {
    static let dataBaseMgr = DBManager()
    class var shared :DBManager {
        return dataBaseMgr
    }
    //
    let DB: Connection?
    
    init() {
        let dir = PathManager.shared.pDocuments()
        let path = dir.appending("/\(DBName)")
        print("The DB Path:", path)
        //如果不存在的话，创建一个名为db.sqlite3的数据库，并且连接数据库
        do {
            DB = try Connection.init(path)
            DB?.busyTimeout = 5
            DB?.busyHandler({ tries in
                if tries >= 3 {
                    return false
                }
                return true
            })
        }catch (let err) {
            DB = nil
            print(err)
        }
    }
    
//    func createTables() throws {
//        do {
//            try DBHelper.createTable()
//        } catch {
//            throw DataAccessError.datastoreConnectionError
//        }
//
//    }
    
}
