//
//  AliPayResultStatus.swift
//  newTest
//
//  Created by one on 2020/7/7.
//  Copyright © 2020 one. All rights reserved.
//

/// 支付返回码表
public class AliPayResultStatus {
    
    /// 订单支付成功,唯一肯定是支付成功的
    public static let PAY_SUCCESS:String = "9000"
    
    /// 正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
    public static let PAY_PROCESSING:String = "8000"
    
    /// 订单支付失败
    public static let PAY_FAIL:String = "4000"
    
    /// 重复请求
    public static let PAY_REPEAT:String = "5000"
    
    /// 用户中途取消
    public static let PAY_PROCESS_CANCEL:String = "6001"
    
    /// 网络连接出错
    public static let PAY_NET_ERROR:String = "6002"
    
    /// 支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
    public static let PAY_UNKNOWN:String = "6004"
}
