//
//  HttpMannager.swift
//  newTest
//
//  Created by one on 2020/6/18.
//  Copyright © 2020 one. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum MothodType{
    case get
    case post
}


private let httpMgr = HttpManager()
class HttpManager {
    class var shared :HttpManager {
        return httpMgr
    }
    
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - type: <#type description#>
    ///   - URLString: <#URLString description#>
    ///   - paramaters: <#paramaters description#>
    ///   - finishCallBack: <#finishCallBack description#>
    func requestDatas(_ type :MothodType, URLString :String, paramaters :[String : Any]?, finishCallBack :@escaping (_ response : Any) ->(), nilCallBack :@escaping (_ response : Any) ->()){
        
        //请求类型
        let mothod = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: mothod, parameters: paramaters, encoding: URLEncoding.default, headers: nil).responseJSON { (responseJson) in
            
            //判断是否请求成功
            guard responseJson.result.value != nil else {
                print(responseJson.error ?? "error")
                nilCallBack(0)
                return
            }
            
            //获取结果
            guard responseJson.result.isSuccess else {
                nilCallBack(1)
                return
            }
            
            if let value = responseJson.result.value {
                finishCallBack(value)
            }
            
        }
    }
    
    
    func useHttp(){
        //请求网络数据
        let param = ["s" : "api/test/list"];
        let url = "http://onapp.yahibo.top/public"
        HttpManager.shared.requestDatas(.get, URLString: url, paramaters: param, finishCallBack: {[weak self] (response) in
            guard self != nil else{
//                self?.tableview.mj_header?.endRefreshing()
                return
            }
            let jsonData = JSON(response)
            //print(jsonData["data"])
            if let object = ModelTest.deserialize(from: jsonData["data"].rawString()) {
//                self?.model = object;
//                self?.tableview.reloadData();
//                self?.tableview.mj_header?.endRefreshing()
            }
        }) {[weak self] (code) in
//            self?.tableview.mj_header?.endRefreshing()
        }
    }
}
