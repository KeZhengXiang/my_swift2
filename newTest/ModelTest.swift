//
//  ModelTest.swift
//  newTest
//
//  Created by one on 2020/6/18.
//  Copyright © 2020 one. All rights reserved.
//  测试model

import HandyJSON

class ModelTest: HandyJSON {
    var page: Int?
    var size: Int?
    var list: Array<ModelTestCell> = []
    
    required init() {}
}

class ModelTestCell: HandyJSON {
    var headimg: String?
    var name: String?
    var id: Int?
    var description: String?
    
    required init() {}
}
