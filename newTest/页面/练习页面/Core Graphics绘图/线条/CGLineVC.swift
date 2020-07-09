//
//  CGLineVC.swift
//  newTest
//
//  Created by one on 2020/7/2.
//  Copyright © 2020 one. All rights reserved.
//  绘制线条:(线段 圆弧 贝塞尔曲线)

import UIKit

 
class CGLineVC: BaseViewController {
    var _h :CGFloat = kNavigationBarHeight + 10//迭代高
    var _s :CGFloat = 30//上下间隔
    //线段
    lazy var lineV: CGLineView = {
        let rw :CGFloat = 250
        let rh :CGFloat = 100
        let v = CGLineView(frame: CGRect(x: (view.bounds.width - rw)/2, y: _h, width: rw, height: rh))
        _h += rh + _s
        return v
    }()
    
    //圆弧 CGArcView
    lazy var arcV: CGArcView = {
        let rw :CGFloat = 250
        let rh :CGFloat = 250
        let v = CGArcView(frame: CGRect(x: (view.bounds.width - rw)/2, y: _h, width: rw, height: rh))
        _h += rh + _s
        return v
    }()
    
    // 贝塞尔曲线 CGQuadCurveView
    lazy var quadCurveV: CGQuadCurveView = {
        let rw :CGFloat = 250
        let rh :CGFloat = 100
        let v = CGQuadCurveView(frame: CGRect(x: (view.bounds.width - rw)/2, y: _h, width: rw, height: rh))
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
        
        self.title = "绘·线条"
        view.backgroundColor = UIColor.black
        
        
        label1.text = "线段"
        self.view.addSubview(label1)
        self.view.addSubview(lineV)
        
        label2.text = "圆弧"
        self.view.addSubview(label2)
        self.view.addSubview(arcV)
        
        label3.text = "贝塞尔曲线"
        self.view.addSubview(label3)
        self.view.addSubview(quadCurveV)
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}
