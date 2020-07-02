//
//  CGGradient3.swift
//  newTest
//
//  Created by one on 2020/7/2.
//  Copyright © 2020 one. All rights reserved.
//  渐变填充矩形
import UIKit

class CGGradient3:UIView {
     
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
         
        //创建clip矩形
        let rect1 = CGRect(x: 0, y: 0,
                           width: self.bounds.width/4, height: self.bounds.height/2)
        let rect2 = CGRect(x: self.bounds.maxX/4, y: self.bounds.maxY/2,
                           width: self.bounds.width/4, height: self.bounds.height/2)
        let rect3 = CGRect(x: self.bounds.maxX/2, y: 0,
                           width: self.bounds.width/4, height: self.bounds.height/2)
        let rect4 = CGRect(x: self.bounds.maxX/4*3, y: self.bounds.maxY/2,
                           width: self.bounds.width/4, height: self.bounds.height/2)
        context.clip(to: [rect1, rect2, rect3, rect4])
         
        //使用rgb颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //颜色数组（这里使用三组颜色作为渐变）fc6820
        let compoents:[CGFloat] = [0xfc/255, 0x68/255, 0x20/255, 1,
                                   0xfe/255, 0xd3/255, 0x2f/255, 1,
                                   0xb1/255, 0xfc/255, 0x33/255, 1]
        //没组颜色所在位置（范围0~1)
        let locations:[CGFloat] = [0,0.5,1]
        //生成渐变色（count参数表示渐变个数）
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: compoents,
                                  locations: locations, count: locations.count)!
         
        //渐变开始位置
        let start = CGPoint(x: self.bounds.minX, y: self.bounds.minY)
        //渐变结束位置
        let end = CGPoint(x: self.bounds.maxX, y: self.bounds.minY)
        //绘制渐变
        context.drawLinearGradient(gradient, start: start, end: end,
                                   options: .drawsBeforeStartLocation)
    }
}
