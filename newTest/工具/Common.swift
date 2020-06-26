//
//  Common.swift
//  my_swift2
//
//  Created by one on 2020/6/18.
//  Copyright © 2020 one. All rights reserved.
//

//宏文件

import UIKit

//屏幕宽高
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

//导航条高度
let kNavigationBarHeight = CGFloat(isLiuHaiScreen ? 88.0 : 64.0)
//状态栏高度
let kStatusBarHeight = CGFloat(isLiuHaiScreen ? 44 : 20)
//TabBar高度
let kTabBarHeight = CGFloat(isLiuHaiScreen ? (49+34) : 49)

//底部安全高度
let kBottomSafeHeight = CGFloat(isLiuHaiScreen ? 34.0 : 0.0)

//自定义颜色
func kRGB(_ r :CGFloat, _ g :CGFloat, _ b :CGFloat) -> UIColor{
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1);
}
func kRGB(_ r :Int, _ g :Int, _ b :Int) -> UIColor{
    return kRGB(CGFloat(r),CGFloat(g),CGFloat(b))
}

//自定义颜色
func kFont(fontSize: CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: fontSize)
}

//根视图
let KeyWindow = UIApplication.shared.keyWindow

let isIpad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad

let isIphone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone

//安全区域
var kSafeAreaInsets :UIEdgeInsets? = {
    if #available(iOS 11, *) {
        if let w = UIApplication.shared.delegate?.window,
            let unwrapedWindow = w {
            print(unwrapedWindow.safeAreaInsets)
            //刘海屏：
            //竖屏：UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0)
            //横屏：UIEdgeInsets(top: 0.0, left: 44.0, bottom: 21.0, right: 44.0)
            
            
            return unwrapedWindow.safeAreaInsets
        }
        return nil
    }
    return nil
}()

//是否是刘海屏
var isLiuHaiScreen: Bool {
    if #available(iOS 11, *) {
        if let safeAreaInsets = kSafeAreaInsets,
            safeAreaInsets.left > 0 || safeAreaInsets.bottom > 0 {
            return true
        }
    }
    return false
}


/// 文本自适应宽高
/// - Parameters:
///   - text: 字符串
///   - fontSize: 字体
///   - width: 限制宽度
/// - Returns: 高度
func heightOfCell(text : String, fontSize : CGFloat, width : CGFloat) -> CGFloat {
    let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontSize)]
    let option = NSStringDrawingOptions.usesLineFragmentOrigin
    let rect:CGRect = text.boundingRect(with: CGSize(width: width, height: 0), options: option, attributes: attributes, context: nil)
//    print("height is \(rect.size.height)")
    return rect.size.height
}


//获取随机数
func getRandom(){
    //1:下面是使用arc4random函数求一个1~100的随机数（包括1和255）
//    let randomNumber:Int = Int(arc4random() % 255) + 1
//    print(randomNumber)
    //func arc4random_uniform(_: UInt32) -> UInt32.接受一个 UInt32 的数字 n 作为输入，将结果归一化到 0 到 n - 1 之间。只要我们的输入不超过 Int 的范围，就可以避免危险的转换：
    let randomNumberTwo:Int = Int(arc4random_uniform(255))+1
    print(randomNumberTwo)
    // 如果想指定区间的最小值（如随机数区间在[5, 100)
    // let max: UInt32 = 100
    // let min: UInt32 = 5
    // arc4random_uniform(max - min) + min
}
