//
//  NavigationVC.swift
//  newTest
//
//  Created by one on 2020/6/19.
//  Copyright © 2020 one. All rights reserved.
//


import UIKit

class NavigationVC : BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = "导航栏"
        
//        //自定义标题视图
//        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
//        titleLabel.textAlignment = NSTextAlignment.center
////        titleLabel.backgroundColor = UIColor.gray
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
//        titleLabel.textColor = UIColor.blue
//        titleLabel.text = "导航栏"
//        self.navigationItem.titleView = titleLabel
        
        
        
        /*----------------UINavigationBar导航栏背景设置------------------*/
        //MARK: - 控制显示隐藏导航栏
//        let isHd = false
//        // 方式一：会干掉右滑退出手势
//        self.navigationController?.isNavigationBarHidden = isHd
//
//        // 方式二：会干掉右滑退出手势，但是可以有动画效果
//        self.navigationController?.setNavigationBarHidden(isHd, animated: true)
//
//        // 方式三：会保留右滑退出手势
//        self.navigationController?.navigationBar.isHidden = isHd
        
        //MARK: - 其他导航栏风格
        //设置导航栏背景风格
//        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
//
//        //设置导航栏的半透明效果，默认是yes
//        self.navigationController?.navigationBar.isTranslucent = false
        
        //设置导航栏的背景颜色(必须有半透明效果)
//        self.navigationController?.navigationBar.backgroundColor = UIColor.green
        
        //将导航上所有的Label的字体变色
//        self.navigationController?.navigationBar.tintColor = UIColor.red
        
        //设置图片作为导航栏的背景,设置了背景图片，导航栏就不透明
//        let width = kScreenW
//        let height = kTabBarHeight
//        var img = UIImage(named: "navbar_bg_normal")
//        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
//        img?.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
//        img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        
        
        //设置提示文本,通常用不上, 为nil消失
//        self.navigationItem.prompt = "提示文本";
        //MARK: - 导航栏自定义两侧按钮
        /*----------------------UINavigationItem两侧按钮----------------*/
        let leftItem1 = UIBarButtonItem(title: "anniu", style: UIBarButtonItem.Style.done, target: self, action: #selector(leftAnniuClick))
//        self.navigationItem.leftBarButtonItem = leftItem1//第一种方式

        let leftItem2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.bookmarks, target: self, action: #selector(btnClick(btn:)))
//        self.navigationItem.leftBarButtonItem = leftItem2//第一种方式
        //第二种方式
        self.navigationItem.leftBarButtonItems = [leftItem1, leftItem2]
        
        //第三种方式（自定义按钮）
        let rightButton = UIButton(type: UIButton.ButtonType.custom)
        rightButton.setTitle("右侧按钮", for: .normal)
        rightButton.setTitleColor(UIColor.red, for: .normal)
        rightButton.tintColor = UIColor.red
        rightButton.frame = CGRect(x: 0, y: 0, width: 33, height: 32)
//        rightButton.addTarget(self, action: #selector(rightButton), for: .touchUpInside)
        rightButton.addTarget(self,action:#selector(rightBtnClick),for:.touchUpInside)
//        rightButton.setImage(UIImage(named: "navbar_bg_normal"), for: UIControl.State.normal)
        let rightItem = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightItem
        
        
        
        
        
        
        
        /*--------------------------------------*/
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: 10, y: 150, width: 200, height: 30)
        button.setTitle("刷新", for: .normal)
        button.addTarget(self,action:#selector(jump),for:.touchUpInside)
        self.view.addSubview(button);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    @objc func jump(){
        print("点击")
//        self.viewWillLayoutSubviews()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    
    @objc func titleViewBtnClick(btn: UIButton) {
        print("标题被点击了")
        
    }
    @objc func leftAnniuClick() {
        print("anniu被点击了")
        
    }
    @objc func btnClick(btn: UIButton) {
        print("btnClick")
        
    }
    @objc func rightBtnClick() {
        print("rightBtnClick")
        self.navigationController?.popViewController(animated: true)
    }
    
}

