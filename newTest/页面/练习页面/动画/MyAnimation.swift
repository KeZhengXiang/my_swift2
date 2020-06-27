//
//  MyAnimation.swift
//  newTest
//
//  Created by one on 2020/6/27.
//  Copyright © 2020 one. All rights reserved.
//  基础动画
//  https://developer.apple.com/documentation/uikit/uiview
//  参考博客： https://www.jianshu.com/p/71f2fa270b9c

import UIKit
import SnapKit



class  MyAnimation: UIViewController {
    
    let initPos :CGRect = CGRect(x: 100, y: 100, width: 100, height: 100)
    
    let imagePos :CGRect = CGRect(x:0, y: kNavigationBarHeight + 200, width: 1080 / 4, height: 1920/4)
    lazy var view1 :UIView = {
        let v = UIView(frame: initPos)
        v.backgroundColor = UIColor.red
        return v
    }()
    //#imageLiteral #imageLiteral(resourceName: "5e9e6df83a2eb")
    lazy var image :UIImageView = {
        let v = UIImageView(image: #imageLiteral(resourceName: "navbar_bg_normal"))
        v.frame = imagePos
        return v
    }()
    
    //
    lazy var btn :UIButton = {
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: kScreenW - 100, y: 110, width: 100, height: 30)
        button.setTitle("还原", for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self,action:#selector(jump),for:.touchUpInside)
        return button
    }()
    lazy var btn1 :UIButton = {
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: kScreenW - 100, y: 150, width: 100, height: 30)
        button.setTitle("平移", for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self,action:#selector(jump1),for:.touchUpInside)
        return button
    }()
    lazy var btn2 :UIButton = {
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: kScreenW - 100, y: 190, width: 100, height: 30)
        button.setTitle("循环5次", for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self,action:#selector(jump2),for:.touchUpInside)
        return button
    }()
    lazy var btn3 :UIButton = {
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: kScreenW - 120 - 70, y: 250, width: 120, height: 30)
        button.setTitle("平移 旋转 缩放", for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self,action:#selector(jump3),for:.touchUpInside)
        return button
    }()
    lazy var btn32 :UIButton = {
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: kScreenW - 60, y: 250, width: 60, height: 30)
        button.setTitle("还原", for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self,action:#selector(jump32),for:.touchUpInside)
        return button
    }()
    lazy var btn4 :UIButton = {
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: kScreenW - 100, y: 290, width: 100, height: 30)
        button.setTitle("弹性动画", for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self,action:#selector(jump4),for:.touchUpInside)
        return button
    }()
    lazy var btn5 :UIButton = {
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: kScreenW - 100, y: 330, width: 100, height: 30)
        button.setTitle("关键帧动画", for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self,action:#selector(jump5),for:.touchUpInside)
        return button
    }()
    lazy var btn6 :UIButton = {
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: kScreenW - 120, y: 380, width: 120, height: 30)
        button.setTitle("image过渡动画", for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self,action:#selector(jump6),for:.touchUpInside)
        return button
    }()
    
    lazy var btn7 :UIButton = {
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: kScreenW - 120, y: 420, width: 120, height: 30)
        button.setTitle("image帧动画", for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self,action:#selector(jump7),for:.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        title = "动画"
        
        view.addSubview(image)
        view.addSubview(view1)
        
        //执行
        self.view.addSubview(btn)
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        self.view.addSubview(btn3); self.view.addSubview(btn32)
        self.view.addSubview(btn4)
        self.view.addSubview(btn5)
        self.view.addSubview(btn6)
        self.view.addSubview(btn7)
        print("self.view1.center = \(self.view1.center)")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view1.layer.removeAllAnimations()
        
    }
    
    
    
    @objc func jump(){
        //取消动画
        view1.layer.removeAllAnimations()
        view1.frame = initPos
        
    }
    @objc func jump1(){
        jump()
        /*
         withDuration：动画的持续时间，也可理解为动画的执行速度，持续时间越小速度越快
         delay：动画开始之前的延时，默认是无延时。
         options：一个附加选项，UIViewAnimationOptions 可以指定多个
         animations：执行动画的闭包
         completion：动画完成后执行的闭包，可以为nil，可以在这里链接下一个动画*/

        /*UIView.AnimationOptions:
         ...
         repeat ： 指定这个选项后，动画会无限重复
        .autoreverse：往返动画，从开始执行到结束后，又从结束返回开始。
         */
        
        //单纯无限重复
//        let options = UIView.AnimationOptions.repeat
        //集合[往返、无限重复、特定运动时间曲线]
        let options: UIView.AnimationOptions = [.autoreverse , .repeat, .curveEaseOut]
        UIView.animate(withDuration: 1.0, delay: 0.0, options: options, animations: { [weak self] () in
            self?.view1.frame = CGRect(x: 100, y: 400, width: 100, height: 100)
        },completion: complete)
    }
    
    func complete(bool :Bool){
        print("animation complete status: bool = \(bool)")
    }
    
    @objc func jump2(){
            jump()
        let options: UIView.AnimationOptions = .autoreverse
        UIView.animate(withDuration: 1.0, delay: 0.0, options: options, animations: { [weak self] () in
            //此方法官方不推荐使用，设置循环次数
            UIView.setAnimationRepeatCount(5)
            
            self?.view1.frame = CGRect(x: 100, y: 400, width: 100, height: 100)
        }) { (bool) in
            print("animation complete status: bool = \(bool)")
        }
    }
    
    @objc func jump3(){
        
        //self.view5.transform = CGAffineTransform.identity//还原调用
//        let options: UIView.AnimationOptions = .autoreverse
        UIView.animate(withDuration: 1.2) {
          self.view1.transform = CGAffineTransform.identity
            .translatedBy(x: -100, y: 0)//平移
            .rotated(by:CGFloat(Double.pi/4))//旋转
            .scaledBy(x: 0.5, y: 0.5)//缩放
        }
    }
     @objc func jump32(){
        self.view1.transform = CGAffineTransform.identity//还原调用
    }
    
    @objc func jump4(){
        jump()
        /*
         usingSpringWithDamping 小于1，动画在最终位置都会有一个摇摆。值越小摇晃的越缓和。
         initialSpringVelocity 表示一个初始速度*/
        UIView.animate(withDuration: 1 , delay: 0 , usingSpringWithDamping: 0.3 , initialSpringVelocity: 8 , options: [] , animations: {
          self.view1.center.y += 100
        }, completion: complete)
    }
    
    //关键帧动画
    @objc func jump5(){
        jump()
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: [.allowUserInteraction], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0 , relativeDuration: 0.5 , animations: {
                self.view1.center.y += 100
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5 , relativeDuration: 1.0 , animations: {
                self.view1.center.x += 100
            })
        }, completion: complete)
        
    }
    
    //Transitions 过渡动画
    @objc func jump6(){
        /*.transitionFlipFromLeft,.transitionFlipFromRight
        .transitionFlipFromTop,.transitionFlipFromBottom
        .transitionCurlUp,.transitionCurlDown
        .transitionCrossDissolve*/
        let arr :Array = [UIView.AnimationOptions.transitionFlipFromLeft, UIView.AnimationOptions.transitionFlipFromRight, UIView.AnimationOptions.transitionFlipFromTop,UIView.AnimationOptions.transitionFlipFromBottom, UIView.AnimationOptions.transitionCurlUp, UIView.AnimationOptions.transitionCurlDown, UIView.AnimationOptions.transitionCrossDissolve]
        let op :UIView.AnimationOptions = arr[Int(arc4random_uniform(7))]
        UIView.transition(with: self.image , duration: 0.6 , options: op, animations: {
          if self.image.image == #imageLiteral(resourceName: "navbar_bg_normal") {
            self.image.image = #imageLiteral(resourceName: "5e9e6df83a2eb")
          }else{
            self.image.image = #imageLiteral(resourceName: "navbar_bg_normal")
          }
        }, completion: complete(bool:))
        
    }
    
    //Transitions 帧动画
    @objc func jump7(){
        let rabbit = #imageLiteral(resourceName: "navbar_bg_normal")
        let empty = #imageLiteral(resourceName: "5e9e6df83a2eb")
//        UIGraphicsBeginImageContextWithOptions(rabbit.size , false, 0)
//        let empty = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
        let arr = [rabbit,empty,rabbit,empty,rabbit]
        image.animationImages = arr
        image.animationDuration = 1//时长
        image.animationRepeatCount = 1//执行次数
        image.startAnimating()
    }
}
