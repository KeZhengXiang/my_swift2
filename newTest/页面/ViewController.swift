//
//  ViewController.swift
//  my_swift2
//
//  Created by one on 2020/6/17.
//  Copyright © 2020 one. All rights reserved.
//  从者云集-学习Demo

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    
    lazy var btnJump :UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 10, y: 150, width: 200, height: 30)
        button.center = view.center
        button.setTitle("进入测试页面", for: .normal)
        button.backgroundColor = UIColor.green
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "首页"
        view.backgroundColor = UIColor.systemYellow
        
        printViewParam()
        
        btnJump.addTarget(self,action:#selector(jump),for:.touchUpInside)
        self.view.addSubview(btnJump);
        
        //请求网络数据
//        HttpManager.shared.useHttp()
        
        let identifier = Bundle.main.bundleIdentifier
        print("identifier = \(identifier!)")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    //跳转到另一个视图
    @objc func jump(){
        
        print("点击按钮，开始跳转！")
        let anotherVC = TestMain()
        //1
//        present(anotherVC, animated: true, completion: nil)
        //2
        self.navigationController?.pushViewController(anotherVC, animated: true)
    }

    
    

    func printViewParam(){
        print("全屏宽高 (kScreenW,kScreenH):（\(kScreenW)，\(kScreenH)）")
        print("导航条高度 kNavigationBarHeight: \(kNavigationBarHeight)")
        print("状态栏高度 kStatusBarHeight: \(kStatusBarHeight)")
        print("TabBar高度 kTabBarHeight: \(kTabBarHeight)")
        print("底部安全高度 kBottomSafeHeight:  \(kBottomSafeHeight)")
        print("安全区域 kSafeAreaInsets:  \(kSafeAreaInsets!)")
    }
}
