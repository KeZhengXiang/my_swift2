//
//  MySafeAreaInsets.swift
//  my_swift2
//
//  Created by one on 2020/6/18.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit


class MySafeAreaInsets: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "安全区域展示"
        self.view.backgroundColor = kRGB(255, 255, 255)
        
        self.navigationController?.navigationBar.isTranslucent = true//半透明
        
        self.view.addSubview(statusView)
        self.view.addSubview(bottomView)
        self.view.addSubview(navView)
        
        self.view.addSubview(btn)
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        self.view.addSubview(btn3)
        
        btn2Up()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - 点击回调
    @objc func btnUp(){
        guard navigationController != nil else {
            return
        }
        //会干掉右滑退出手势
//        let isHd = !navigationController!.isNavigationBarHidden
//        self.navigationController?.setNavigationBarHidden(isHd, animated: true)
        //会保留右滑退出手势
        let isHd = !navigationController!.navigationBar.isHidden
        navigationController?.navigationBar.isHidden = isHd
    }
    
    @objc func btn1Up(){
        statusView.isHidden = false
        bottomView.isHidden = true
        navView.isHidden = true
    }
    
    @objc func btn2Up(){
        statusView.isHidden = true
        bottomView.isHidden = false
        navView.isHidden = true
    }
    
    @objc func btn3Up(){
        statusView.isHidden = true
        bottomView.isHidden = true
        navView.isHidden = false
    }
    
    //MARK: - lazy
    // 显隐导航条     顶部状态栏（默认）   底部安全区（默认）   导航条栏
    
    lazy var statusView:UIView = {
        let v:UIView = UIView()
        v.backgroundColor = kRGB(255, 0, 0)
        v.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kStatusBarHeight)
        return v
    }()
    
    lazy var bottomView:UIView = {
        let v:UIView = UIView()
        v.backgroundColor = kRGB(255, 0, 0)
        v.frame = CGRect(x: 0, y: kScreenH - kBottomSafeHeight, width: kScreenW, height: kBottomSafeHeight)
        return v
    }()
    
    lazy var navView:UIView = {
        let v:UIView = UIView()
        v.backgroundColor = kRGB(255, 0, 0)
        v.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kNavigationBarHeight)
        return v
    }()
    
    var _w:CGFloat = 150
    var _h:CGFloat = 30
    var _y:CGFloat = 150
    lazy var btn :UIButton = {
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: kScreenW - _w, y: _y, width: _w, height: _h)
        _y+=_h+10
        button.setTitle("显隐导航条", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self,action:#selector(btnUp),for:.touchUpInside)
        return button
    }()
    lazy var btn1 :UIButton = {
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: kScreenW - _w, y: _y, width: _w, height: _h)
        _y+=_h+10
        button.setTitle("顶部状态栏", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self,action:#selector(btn1Up),for:.touchUpInside)
        return button
    }()
    lazy var btn2 :UIButton = {
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: kScreenW - _w, y: _y, width: _w, height: _h)
        _y+=_h+10
        button.setTitle("底部安全区", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self,action:#selector(btn2Up),for:.touchUpInside)
        return button
    }()
    lazy var btn3 :UIButton = {
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: kScreenW - _w, y: _y, width: _w, height: _h)
        _y+=_h+10
        button.setTitle("导航条栏", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self,action:#selector(btn3Up),for:.touchUpInside)
        return button
    }()
    
}
