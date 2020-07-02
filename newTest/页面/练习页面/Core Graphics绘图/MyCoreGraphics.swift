//
//  MyCoreGraphics.swift
//  newTest
//
//  Created by one on 2020/7/2.
//  Copyright © 2020 one. All rights reserved.
//  绘制


import UIKit
 
class MyCoreGraphics: UIViewController {
    var _h :CGFloat = kNavigationBarHeight + 200//迭代高
    var _s :CGFloat = 30//上下间隔
    
    
    lazy var btn1 :UIButton = {
        let rw :CGFloat = 250
        let rh :CGFloat = 40
        let btn = UIButton(frame: CGRect(x: view.bounds.midX - rw/2, y: _h, width: rw, height: rh))
        btn.backgroundColor = UIColor.systemYellow
        btn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        _h += rh + _s
        return btn
    }()
    
    lazy var btn2 :UIButton = {
        let rw :CGFloat = 250
        let rh :CGFloat = 40
        let btn = UIButton(frame: CGRect(x: view.bounds.midX - rw/2, y: _h, width: rw, height: rh))
        btn.backgroundColor = UIColor.systemYellow
        btn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        _h += rh + _s
        return btn
    }()
    
    lazy var btn3 :UIButton = {
        let rw :CGFloat = 250
        let rh :CGFloat = 40
        let btn = UIButton(frame: CGRect(x: view.bounds.midX - rw/2, y: _h, width: rw, height: rh))
        btn.backgroundColor = UIColor.systemYellow
        btn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        _h += rh + _s
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Core Graphics绘图"
        view.backgroundColor = UIColor.black
        
        
        //(线段 圆弧 贝塞尔曲线)
        btn1.setTitle("绘·线条", for: UIControl.State.normal)
        btn1.addTarget(self, action: #selector(goLine), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn1)
        
        //(线段 圆弧 贝塞尔曲线)
        btn2.setTitle("绘·图形", for: UIControl.State.normal)
        btn2.addTarget(self, action: #selector(goGrap), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn2)
        
        //(线段 圆弧 贝塞尔曲线)
        btn3.setTitle("绘·渐变", for: UIControl.State.normal)
        btn3.addTarget(self, action: #selector(goGardient), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn3)
    }
     
    
    @objc func goLine(){
        self.navigationController?.pushViewController(CGLineVC(), animated: true)
    }
    
    @objc func goGrap(){
        self.navigationController?.pushViewController(CGGraphicsVC(), animated: true)
    }
    
    @objc func goGardient(){
        self.navigationController?.pushViewController(CGGradientVC(), animated: true)
    }
    
    
    
}
