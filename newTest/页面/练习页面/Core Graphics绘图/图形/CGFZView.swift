//
//  CGFZView.swift
//  newTest
//
//  Created by one on 2020/7/2.
//  Copyright © 2020 one. All rights reserved.
//  自定义图形
// https://www.hangge.com/blog/cache/detail_941.html

import UIKit

class CGFZView: UIView {
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
     
    override func draw(_ rect: CGRect) {
        super.draw(rect)
         
        //为两个组成部分定义矩形
        let squareRect = self.bounds.insetBy(dx: self.bounds.size.width * 0.05,
                                             dy: self.bounds.size.height * 0.45)
         
        let circleRect = self.bounds.insetBy(dx: self.bounds.size.width * 0.3,
                                             dy: self.bounds.size.height * 0.3)
         
        //创建一条空Bezier路径作为主路径
        let bezierPath = UIBezierPath()
         
        //创建子路径
        let circlePath = UIBezierPath(ovalIn: circleRect)
        let squarePath = UIBezierPath(roundedRect: squareRect, cornerRadius: 20)
         
        //将它们添加到主路径
        bezierPath.append(circlePath)
        bezierPath.append(squarePath)
         
        //设定颜色，并绘制它们
        UIColor.blue.setFill()
//        UIColor.green.setFill()
        UIColor.black.setStroke()
        bezierPath.fill()
        //bezierPath.stroke()
    }
}
