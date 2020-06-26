//
//  StringExtension.swift
//  newTest
//
//  Created by one on 2020/6/18.
//  Copyright © 2020 one. All rights reserved.
//

//import Foundation


extension String {
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
}
