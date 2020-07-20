//
//  BasePageViewController.swift
//  newTest
//
//  Created by one on 2020/7/19.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit

class BasePageViewController :UIPageViewController{
    
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
        
        if(isNavSpecialHidden){
            navigationController?.setNavigationBarHidden(true, animated: false)
            navigationController?.setNavigationBarHidden(false, animated: false)
            navigationController?.navigationBar.isHidden = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("@@离开页面：\(self.classForCoder)")
    }
    
    deinit {
        print("@@销毁页面：\(self.classForCoder)")
    }
}

