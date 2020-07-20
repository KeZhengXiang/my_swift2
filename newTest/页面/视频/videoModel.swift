//
//  videoModel.swift
//  newTest
//
//  Created by one on 2020/7/13.
//  Copyright © 2020 one. All rights reserved.
//
//  api:https://github.com/alibaba/HandyJSON


import HandyJSON

//videos

class VideoModels: HandyJSON {
    
    var videos:[VideoModel]?
    
    required init() {
        
        
    }
}
class VideoModel: HandyJSON {
    
    var id:Int?//视频id
    var url:String?//视频地址
    var cover:String?//视频封面
    var title:String?//标题
    var city:String?//城市

    var likeNum:Int?//点赞数
    var commentNum:Int?//评论数
    var shareNum:Int?//分享数
    
    
//    var tags:[String]?//标签
//    var author:VideoAuthorModel?//作者
    
    required init() {
        
        
    }
}


class VideoAuthorModel: HandyJSON {
    
    var id:Int?//用户id
    var name:String?//名字
    var avatar:String?//头像
    
    required init() {
        
        
    }
}
