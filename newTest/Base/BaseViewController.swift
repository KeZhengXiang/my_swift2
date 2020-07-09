//
//  KViewController.swift
//  newTest
//
//  Created by one on 2020/7/7.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit

class BaseViewController :UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("@@页面加载完成：\(self.classForCoder)")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        print("@@即将进入页面：\(self.classForCoder)")
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
