//
//  DBSHProtocl.swift
//  newTest
//
//  Created by one on 2020/6/30.
//  Copyright © 2020 one. All rights reserved.
//

import Foundation


///协议，声明一系列增删改查的操作
protocol DBSHProtocl {
    
    associatedtype T
    associatedtype KEY
    
    static func createTable() throws -> Void
    
    static func insert(item: T) throws -> Int
    
    static func find(key: KEY) throws -> [T]
    
}

//Optional implementation  可选接口
extension DBSHProtocl {
    static func update(item: T) throws -> Bool {return false}
    
    static func delete(item: T) throws -> Bool {return false}
    
    static func checkColimnExists(ID: Int) throws -> Bool { return false }
    
}
