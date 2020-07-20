//
//  MySegmentedControl.swift
//  newTest
//
//  Created by one on 2020/7/19.
//  Copyright © 2020 one. All rights reserved.
//  参考： https://www.hangge.com/blog/cache/detail_533.html
//  API： https://developer.apple.com/documentation/uikit/uisegmentedcontrol

import Foundation

import UIKit
 
class MySegmentedControl: BaseViewController {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
         
        //选项除了文字还可以是图片
        let items = ["选项一", "选项二", UIImage(named: "ic_story_paint_232x32")! ] as [Any]
        let segmented = UISegmentedControl(items:items)
//        segmented.center = self.view.center
        segmented.frame = CGRect(x: 0, y: kNavigationBarHeight, width: kScreenW, height: 40)
        
        //默认选中第二项
        segmented.selectedSegmentIndex = 0
        
        //添加值改变监听
        segmented.addTarget(self, action: #selector(self.segmentDidchange(_:)),
                            for: .valueChanged)
        
        //修改选项颜色（包括图片选项）
        segmented.tintColor = UIColor.systemBlue
        
//        //修改选项文字
//        segmented.setTitle("修改选项文字", forSegmentAt:0)
        
        //设置背景图像。
//        segmented.setBackgroundImage(UIImage(named: "backImage0"), for: UIControl.State.normal, barMetrics: UIBarMetrics.default)
        
        //修改选项内容偏移位置
//        segmented.setContentOffset(CGSize(width:10, height:7), forSegmentAt:1)
        
        //根据其内容宽度调整段宽度
        segmented.apportionsSegmentWidthsByContent = true
        
        self.view.addSubview(segmented)
    }
     
    @objc func segmentDidchange(_ segmented:UISegmentedControl){
        //获得选项的索引
        print(segmented.selectedSegmentIndex)
        //获得选择的文字
        print(segmented.titleForSegment(at: segmented.selectedSegmentIndex) ?? "")
        
    }
    
    
    func insertItem(_ segmented:UISegmentedControl) {
        //添加文字选项
        segmented.insertSegment(withTitle: "新增选项", at:0, animated:true);
        //添加图片选项
        segmented.insertSegment(with: UIImage(named:"icon_home_like_after40x40")!, at:1, animated: true)
    }
    
    func removeItem(_ segmented:UISegmentedControl) {
        //移除选项
        segmented.removeSegment(at: 0, animated:true)
    }
    
    
}




