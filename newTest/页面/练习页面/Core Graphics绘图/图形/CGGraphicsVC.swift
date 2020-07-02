//
//  CGGraphicsVC.swift
//  newTest
//
//  Created by one on 2020/7/2.
//  Copyright © 2020 one. All rights reserved.
//  绘制图形:(矩形 )
// 参考: https://www.hangge.com/blog/cache/detail_1438.html

import UIKit

 
class CGGraphicsVC: UIViewController {
    var _h :CGFloat = kNavigationBarHeight + 10//迭代高
    var _s :CGFloat = 30//上下间隔
    //矩形
    lazy var rectV: CGRectView = {
        let rw :CGFloat = 250
        let rh :CGFloat = 100
        let v = CGRectView(frame: CGRect(x: (view.bounds.width - rw)/2, y: _h, width: rw, height: rh))
        _h += rh + _s
        return v
    }()
    
    //圆
    lazy var ellipV: CGEllipseView = {
        let rw :CGFloat = 250
        let rh :CGFloat = 250
        let v = CGEllipseView(frame: CGRect(x: (view.bounds.width - rw)/2, y: _h, width: rw, height: rh))
        _h += rh + _s
        return v
    }()
    
    // 多条子路径绘制图形 CGQuadCurveView
    lazy var fzV: CGFZView = {
        let rw :CGFloat = 150
        let rh :CGFloat = 150
        let v = CGFZView(frame: CGRect(x: (view.bounds.width - rw)/2, y: _h, width: rw, height: rh))
        _h += rh + _s
        return v
    }()
    
    lazy var label1: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: 0, y: _h, width: view.bounds.width, height: 40)
        lable.textAlignment = .center
        lable.textColor = UIColor.white
        _h += 40 + 0
        return lable
    }()
    lazy var label2: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: 0, y: _h, width: view.bounds.width, height: 40)
        lable.textAlignment = .center
        lable.textColor = UIColor.white
        _h += 40 + 0
        return lable
    }()
    lazy var label3: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: 0, y: _h, width: view.bounds.width, height: 40)
        lable.textAlignment = .center
        lable.textColor = UIColor.white
        _h += 40 + 0
        return lable
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "绘·图形"
        view.backgroundColor = UIColor.black
        
        
        label1.text = "矩形"
        self.view.addSubview(label1)
        self.view.addSubview(rectV)
        
        label2.text = "圆"
        self.view.addSubview(label2)
        self.view.addSubview(ellipV)
        
        label3.text = "多条子路径绘制图形"
        self.view.addSubview(label3)
        self.view.addSubview(fzV)
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
