//
//  CGLine.swift
//  newTest
//
//  Created by one on 2020/7/2.
//  Copyright © 2020 one. All rights reserved.
//  绘制线条
//参考: https://www.hangge.com/blog/cache/detail_1437.html
//API: https://developer.apple.com/documentation/coregraphics/cgmutablepath

import UIKit

class CGLineView:UIView {
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.white
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        /*  步骤
        （1）获取绘图上下文
        （2）创建并设置路径
        （3）将路径添加到上下文
        （4）设置上下文状态（如笔触颜色、宽度、填充色等等）
        （5）绘制路径
        */
         
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
         
        //创建一个矩形，它的所有边都内缩3
        let drawingRect = self.bounds.insetBy(dx: 8, dy: 8)
        print("drawingRect = \(drawingRect)")
        //创建并设置路径
        let path = CGMutablePath()
        path.move(to: CGPoint(x:drawingRect.minX, y:drawingRect.minY))
        path.addLine(to:CGPoint(x:drawingRect.maxX, y:drawingRect.minY))
        path.addLine(to:CGPoint(x:drawingRect.maxX, y:drawingRect.maxY))
         
        //添加路径到图形上下文
        context.addPath(path)
         
        //设置笔触颜色
        context.setStrokeColor(UIColor.orange.cgColor)
        //设置笔触宽度
        context.setLineWidth(6)
        
        ///**********多样化设置 begin**********
        //设置顶点样式（圆角）
        context.setLineCap(.round)
        //设置连接点样式（圆角）
        context.setLineJoin(CGLineJoin.round)
        //设置阴影
        context.setShadow(offset: CGSize(width:3, height:3), blur: 0.6,
                          color: UIColor.lightGray.cgColor)
         
        //虚线每个线段的长度与间隔
        let lengths: [CGFloat] = [15,8]
        //设置虚线样式
        context.setLineDash(phase: 0, lengths: lengths)
        
        ///**********多样化设置 end**********
        
        
        //绘制路径
        context.strokePath()
    }
}
