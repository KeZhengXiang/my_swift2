//
//  AliPaySDK.swift
//  newTest
//
//  Created by one on 2020/7/7.
//  Copyright © 2020 one. All rights reserved.
//  创建名称：从者云集-学习Demo
//  使用支付宝支付sdk
//  BundleID :com.myst.newTest
//  官方： https://opendocs.alipay.com/open/204/105297
//  开发者管理中心（创建应用之处）： https://open.alipay.com/platform/appManage.htm#/apps
//  桥接OC： https://www.cnblogs.com/sundaysme/p/10668587.html
//  appleID = "2021001172686362"
//  签约：当前未签约
/**
 Podfile 添加
  pod 'AlipaySDK-iOS', '~>15.7.4' #支付宝支付SDK  然后拷贝出来放入项目中
 
 添加库：
 libc++.tbd、libz.tbd、AlipaySDK.framework、WebKit.framework
 
 
 
 */
import UIKit
//import Alipay


class AliPaySDK: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
}



class AliPayManager: NSObject {
    static let shared = AliPayManager()
    
    
    // 用于弹出警报视图，显示成功或失败的信息
    fileprivate weak var sender: UIViewController!

    // 支付成功的闭包
    fileprivate var paySuccessClosure: (() -> Void)?

    // 支付失败的闭包
    fileprivate var payFailClosure: (() -> Void)?

    ///登录成功的闭包
    fileprivate var loginSuccessClosure:((_ auth_code:String) -> Void)?

    ///登录失败的闭包
    fileprivate var loginFailClosure:(() -> Void)?

    // 外部用这个方法调起支付支付
    func payAlertController(_ sender: UIViewController, request:String, paySuccess: @escaping () -> Void, payFail:@escaping () -> Void) {
        // sender 是调用这个方法的控制器，
        self.sender = sender

        //用于提示用户支付宝支付结果，可以根据自己需求是否要此参数。
        self.paySuccessClosure = paySuccess
        self.payFailClosure = payFail
//        AlipaySDK.defaultService().payOrder(request, fromScheme:"xxx",callback:nil)
    }

    //外部用这个方法调起支付宝登录
    func login(_ sender:UIViewController,withInfo:String,loginSuccess: @escaping (_ str:String) -> Void,loginFail:@escaping () -> Void){
        // sender 是调用这个方法的控制器，

        // 用于提示用户微信支付结果，可以根据自己需求是否要此参数。

        self.sender = sender

        self.loginSuccessClosure = loginSuccess

        self.loginFailClosure = loginFail
//        AlipaySDK.defaultService().auth_V2(withInfo:withInfo, fromScheme:"xxx", callback:nil)

    }

    ///授权回调
    func showAuth_V2Result(result:NSDictionary){

        //        9000    请求处理成功
        //        4000    系统异常
        //        6001    用户中途取消
        //        6002    网络连接出错

        let returnCode:String = result["resultStatus"] as! String

        var returnMsg:String = ""

        switch returnCode{
        case "6001":
            returnMsg = "用户中途取消"
            break
        case "6002":
            returnMsg = "网络连接出错"
            break
        case "4000":
            returnMsg = "系统异常"
            break
        case "9000":
            returnMsg = "授权成功"
            break
        default:
            returnMsg = "系统异常"
            break
        }
        print("授权结果---\(returnMsg)")
        //  显示授权结果提示框

//        UIAlertController.showAlertYes(sender, title: "授权结果", message: returnMsg, okButtonTitle:"确定", okHandler: { (alert) in

//            if returnCode == "9000" {

//                let r=result["result"] as! String

//                self.loginSuccessClosure?(r)

//

//            }else{

//                self.loginFailClosure?()

//            }

//        })
    }
    //传入回调参数
    func showResult(result:NSDictionary){
        let returnCode:String = result["resultStatus"] as! String

        if returnCode == "9000" {
            self.paySuccessClosure?()
        }else{
            self.payFailClosure?()
        }
    }
}

//作者：不言弃_00b3
//链接：https://www.jianshu.com/p/015f30563ddf
//来源：简书
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


