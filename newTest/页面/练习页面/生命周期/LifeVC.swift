//
//  LifeVC.swift
//  newTest
//
//  Created by one on 2020/6/19.
//  Copyright © 2020 one. All rights reserved.
//  https://www.hangge.com/blog/cache/detail_1319.html

import UIKit

class LifeVC: BaseViewController {
    
    //视图初始化
    override func loadView() {
        super.loadView()
        log(#function)
    }
    
    //视图加载完成
    override func viewDidLoad() {
        super.viewDidLoad()
        log(#function)
    }
    
    //视图将要出现的时候执行
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        log(#function)
    }
    
    //即将布局
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        log(#function)
    }
    
    //已经布局
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        log(#function)
    }
    
    //视图显示完成后执行
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        log(#function)
    }
    
    //视图将要消失的时候执行
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        log(#function)
    }
    
    //视图已经消失的时候执行
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        log(#function)
    }
    
    //收到内存警告时执行
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        log(#function)
    }
    
    deinit {
        log(#function)
    }
    
    
    func log(_ funcStr :String){
        print("------\(self.classForCoder)：\(funcStr)")
    }
}
