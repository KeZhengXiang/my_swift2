//
//  DBSQCode.swift
//  newTest
//
//  Created by one on 2020/6/30.
//  Copyright © 2020 one. All rights reserved.
//  数据库编码相关

import SQLite
import UIKit


//*******************************【编码范例】*************************************
///数组 Encode编码  Decode解码 范例
func arrcode(){
    let strings = ["123","abc","你好吗？"]
    //编码
    let data :Data = try! NSKeyedArchiver.archivedData(withRootObject: strings, requiringSecureCoding: true)

    //解码
    if let arr: [String] = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] {
        print("\(#function)-编码范例: \(arr)")
    }
}
///字符串 Encode编码  Decode解码 范例
func strcode(){
    // String -> Data
    let str: String = "Apple"
    let data: Data = str.data(using: String.Encoding.utf8)!
    
    // Data -> String
    let outStr: String = NSString(data:data, encoding:String.Encoding.utf8.rawValue)! as String
    print("\(#function)-编码范例: \(outStr)")
}

//************************************************************************

extension NSData: Value {

    //SQL Type
    public static var declaredDatatype: String {
        return Blob.declaredDatatype
    }

    //Decode 解码
    public static func fromDatatypeValue(_ datatypeValue: Blob) -> NSData {
        return NSData(bytes: datatypeValue.bytes, length: datatypeValue.bytes.count)
    }
    
    //Encode 编码
    public var datatypeValue: Blob {
        return Blob(bytes: self.bytes, length: self.length)
    }

}


extension UIImage: Value {
    
    public static var declaredDatatype: String{
        return Blob.declaredDatatype
    }

    //Decode 解码
    public static func fromDatatypeValue(_ blobValue: Blob) -> UIImage {
        return UIImage(data: Data.fromDatatypeValue(blobValue))!
    }
    //Encode 编码
    public var datatypeValue: Blob {
        return self.pngData()!.datatypeValue
    }
    
}


