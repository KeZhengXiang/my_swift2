//
//  MyTabBarController.swift
//  newTest
//
//  Created by one on 2020/7/8.
//  Copyright © 2020 one. All rights reserved.
//  API: https://developer.apple.com/documentation/uikit/uitabbarcontroller

import Foundation
import UIKit

class MyTabBarController : UITabBarController {
    
    
    
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
        
        title = "tabController"
        view.backgroundColor = UIColor.white
        
        btnJump.addTarget(self,action:#selector(jump),for:.touchUpInside)
        self.view.addSubview(btnJump);
        
        //样式设置 ：https://www.hangge.com/blog/cache/detail_1002.html
        
        ///1、选中时：图片文字一起变色
        self.tabBar.tintColor = UIColor.orange
        ///2、选中时：改变文字颜色
//        UITabBarItem.appearance().setTitleTextAttributes(
//            [NSAttributedString.Key.foregroundColor: UIColor.orange], for:.normal)
//        UITabBarItem.appearance().setTitleTextAttributes(
//            [NSAttributedString.Key.foregroundColor: UIColor.orange], for:.selected)
        
        let vc1 = MyTabVC1()
        vc1.title = "首页"
        vc1.tabBarItem.title = "首页"
        vc1.tabBarItem.image = UIImage(named: "ic_camera_settings40x40")
        
        
        let vc2 = MyTabVC2()
        vc2.title = "item2"
        ///3、选中时、不选中时使用不同图片 且只显示图片，并居中
        vc2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_camera_settings40x40"),
        selectedImage: UIImage(named: "ic_story_paint_132x32"))
        if (isIphone){
            vc2.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        
        
        let vc3 = UINavigationController(rootViewController:MyTabVC3())
        vc3.title = "item3"
        vc3.tabBarItem.title = "item3"
        ///4、只显示文字，居中，调整大小
        vc3.tabBarItem.setTitleTextAttributes(NSDictionary.init(dictionary: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]) as? [NSAttributedString.Key : Any], for: UIControl.State.normal)
        if (isIphone){
            vc3.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -12)
        }
        
        
        ///5、小红点显示
        let vc4 = MyTabVC4()
        vc4.tabBarItem.title = "item4"
        vc4.tabBarItem.image = UIImage(named: "ic_camera_settings40x40")
        vc4.tabBarItem.badgeValue = "1"
        vc4.tabBarItem.badgeColor = UIColor.red
        
        self.viewControllers = [vc1,vc2,vc3,vc4]
        
        self.selectedIndex = 3//初始选择标签
        
        delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
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
}

//UITabBarControllerDelegate
extension MyTabBarController : UITabBarControllerDelegate {
    ///激活标签栏
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        return true
//    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("标签栏点击：\(viewController.title ?? "@@")")
    }
}


