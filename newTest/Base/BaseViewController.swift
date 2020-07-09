//
//  KViewController.swift
//  newTest
//
//  Created by one on 2020/7/7.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit

class BaseViewController :UIViewController{
    
    ///保留返回手势 且 隐藏导航栏
    var isNavSpecialHidden:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("@@页面加载完成：\(self.classForCoder)")
        //导航栏隐藏后没有返回手势的解决方法
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        print("@@即将进入页面：\(self.classForCoder)")
        
        if(isNavSpecialHidden){
            navigationController?.setNavigationBarHidden(false, animated: false)
            navigationController?.navigationBar.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("@@进入页面：\(self.classForCoder)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        print("@@即将离开页面：\(self.classForCoder)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("@@离开页面：\(self.classForCoder)")
    }
}


//
///**导航栏隐藏后没有返回手势的解决方法
// https://www.jianshu.com/p/c61eb4f5f7d0
// https://www.jb51.net/article/122338.htm  -->当前
// viewDidLoad: 加入以下代码
// self.navigationController?.interactivePopGestureRecognizer?.delegate = self
// */
//extension BaseViewController : UIGestureRecognizerDelegate{
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if self.navigationController?.viewControllers.count == 1 {
//          return false
//        }
//        return true
//    }
//}
