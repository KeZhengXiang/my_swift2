//
//  MySafeAreaInsets.swift
//  my_swift2
//
//  Created by one on 2020/6/18.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit


class MySafeAreaInsets: BaseViewController {
    
    //视图初始化
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    //视图加载完成
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        self.title = "安全区域展示"
        self.view.backgroundColor = kRGB(255, 255, 255)
        
        //创建top安全区域
        let topView:UIView = UIView()
        topView.backgroundColor = kRGB(255, 0, 0)
        topView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kSafeAreaInsets?.top ?? 0)
        self.view.addSubview(topView);
        
        //创建底部安全区域
        let bottomView:UIView = UIView()
        bottomView.backgroundColor = kRGB(255, 0, 0)
        bottomView.frame = CGRect(x: 0, y: kScreenH - (kSafeAreaInsets?.bottom ?? 0), width: kScreenW, height: kSafeAreaInsets?.bottom ?? 0)
        self.view.addSubview(bottomView);
    }
    
    //视图将要出现的时候执行
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    //视图显示完成后执行
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = false
        print("viewDidAppear")
    }
    
    //视图将要消失的时候执行
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    //视图已经消失的时候执行
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    //收到内存警告时执行
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
