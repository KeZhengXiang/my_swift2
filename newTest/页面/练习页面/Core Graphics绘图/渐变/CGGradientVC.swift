//
//  CGGradientVC.swift
//  newTest
//
//  Created by one on 2020/7/2.
//  Copyright © 2020 one. All rights reserved.
//  渐变

import UIKit

 
class CGGradientVC: UIViewController {
    var _h :CGFloat = kNavigationBarHeight + 10//迭代高
    var _s :CGFloat = 30//上下间隔
    //
    lazy var gradV1: CGGradient1 = {
        let rw :CGFloat = 250
        let rh :CGFloat = 100
        let v = CGGradient1(frame: CGRect(x: (view.bounds.width - rw)/2, y: _h, width: rw, height: rh))
        _h += rh + _s
        return v
    }()
    //
    lazy var gradV2: CGGradient2 = {
        let rw :CGFloat = 250
        let rh :CGFloat = 100
        let v = CGGradient2(frame: CGRect(x: (view.bounds.width - rw)/2, y: _h, width: rw, height: rh))
        _h += rh + _s
        return v
    }()
    //
    lazy var gradV3: CGGradient3 = {
        let rw :CGFloat = 250
        let rh :CGFloat = 100
        let v = CGGradient3(frame: CGRect(x: (view.bounds.width - rw)/2, y: _h, width: rw, height: rh))
        _h += rh + _s
        return v
    }()
    //
    lazy var gradV4: CGGradient4 = {
        let rw :CGFloat = 250
        let rh :CGFloat = 100
        let v = CGGradient4(frame: CGRect(x: (view.bounds.width - rw)/2, y: _h, width: rw, height: rh))
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
    lazy var label4: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: 0, y: _h, width: view.bounds.width, height: 40)
        lable.textAlignment = .center
        lable.textColor = UIColor.white
        _h += 40 + 0
        return lable
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "绘·渐变"
        view.backgroundColor = UIColor.black
        
        
        label1.text = "绘制线性渐变"
        self.view.addSubview(label1)
        self.view.addSubview(gradV1)
        
        label2.text = "绘制放射性渐变"
        self.view.addSubview(label2)
        self.view.addSubview(gradV2)
        
        label3.text = "渐变·填充矩形"
        self.view.addSubview(label3)
        self.view.addSubview(gradV3)
        
        label4.text = "渐变·填充不规则的图形"
        self.view.addSubview(label4)
        self.view.addSubview(gradV4)
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
