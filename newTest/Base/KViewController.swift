//
//  KViewController.swift
//  newTest
//
//  Created by one on 2020/7/7.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit

class KViewController :UIViewController{
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("进入页面：\(self.classForCoder)")
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("离开页面：\(self.classForCoder)")
    }
}
