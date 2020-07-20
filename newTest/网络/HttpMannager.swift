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
    
    
    
    /// 拉取网络数据
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
    
    /// 请求数据范例
//    func useHttp(){
//        //请求网络数据
//        let param = ["s" : "api/test/list"];
//        let url = "http://onapp.yahibo.top/public"
//        HttpManager.shared.requestDatas(.get, URLString: url, paramaters: param, finishCallBack: {[weak self] (response) in
//            guard self != nil else{
////                self?.tableview.mj_header?.endRefreshing()
//                return
//            }
//            let jsonData = JSON(response)
//            //print(jsonData["data"])
//            if let object = ModelTest.deserialize(from: jsonData["data"].rawString()) {
////                self?.model = object;
////                self?.tableview.reloadData();
////                self?.tableview.mj_header?.endRefreshing()
//            }
//        }) {[weak self] (code) in
////            self?.tableview.mj_header?.endRefreshing()
//        }
//    }
    
    //MARK: 读取本地json文件  ----仿网络拉取
    func readVideos(){
        let path = Bundle.main.path(forResource: "dy_video_json", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
        do {
            /*
             * try 和 try! 的区别
             * try 发生异常会跳到catch代码中
             * try! 发生异常程序会直接crash
             */
            let data = try Data(contentsOf: url)
            //https://www.jianshu.com/p/b6b8825ca460
            if let jsonData:Dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any> {
                let videosJson = JSON(jsonData)
//                print("videos: \(videosJson.rawString() ?? "")")
                if let object = VideoModels.deserialize(from: videosJson.rawString()) {
                    print(object)
                }
            }
            
        } catch let error as Error? {
            print("读取本地数据出现错误!",error ?? "---")
        }
        
    }

}


