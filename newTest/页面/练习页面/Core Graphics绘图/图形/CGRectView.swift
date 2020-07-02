//
//  CGRectView.swift
//  newTest
//
//  Created by one on 2020/7/2.
//  Copyright © 2020 one. All rights reserved.
//  矩形

import UIKit

class CGRectView:UIView {
     
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
         
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
         
        //创建一个矩形，它的所有边都内缩3点
        let drawingRect = self.bounds.insetBy(dx: 3, dy: 3)
         
        //创建并设置路径
        let path = CGMutablePath()
        //绘制矩形
        path.addRect(drawingRect)
        //绘制圆角矩形
//        path.addRoundedRect(in: drawingRect, cornerWidth: 10, cornerHeight: 10)
         
        //添加路径到图形上下文
        context.addPath(path)
         
        //设置笔触颜色
        context.setStrokeColor(UIColor.orange.cgColor)
        //设置笔触宽度
        context.setLineWidth(6)
        //设置填充颜色
        context.setFillColor(UIColor.blue.cgColor)
         
        //绘制路径并填充
        context.drawPath(using: .fillStroke)
    }
}
