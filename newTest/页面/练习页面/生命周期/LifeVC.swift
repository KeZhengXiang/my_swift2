//
//  LifeVC.swift
//  newTest
//
//  Created by one on 2020/6/19.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit


class LifeVC: UIViewController {
    
    
    
    //视图初始化
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    //视图加载完成
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        self.title = "UIViewController 生命周期"
        
    }
    
    //视图将要出现的时候执行
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    //即将布局
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews")
    }
    
    //已经布局
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
    }
    
    //视图显示完成后执行
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    //视图将要消失的时候执行
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    //视图已经消失的时候执行
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    
    //收到内存警告时执行
    override func didReceiveMemoryWarning() {
        print("didReceiveMemoryWarning")
    }
    
    
    
}
