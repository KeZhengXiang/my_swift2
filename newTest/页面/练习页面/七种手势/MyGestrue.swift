//
//  MyGestrue.swift
//  newTest
//
//  Created by one on 2020/7/1.
//  Copyright © 2020 one. All rights reserved.
//  七种手势
/*
 Tap 轻点
 Pinch 捏合
 Rotation 旋转
 Swipe 轻扫
 Pan 平移拖拽
 ScreenEdgePan 屏幕边缘平移
 LongPress长按
 */
//https://blog.csdn.net/qq_44864362/article/details/104237613

import Foundation
import UIKit

class MyGestrue : UIViewController {
    
    lazy var imageV :UIImageView = {
        let imgv = UIImageView(image: UIImage(named: "navbar_bg_normal"))
//        imgv.frame.size = CGSize(width: 1080 / 4, height: 1920/4)
        imgv.frame.size = CGSize(width: kScreenW, height: kScreenH)
        imgv.center = self.view.center
/*
 scaleToFill,       //缩放图片填充满UIImageView
 scaleAspectFit,    //按图片的宽高比缩放，在UIImageView中显示图片整体，多余区域为透明空白, 图片不会变形
 scaleAspectFill,   //按图片的宽高比缩放，填充满UIImageView，超出容器部分会被裁减
 redraw,            // bounds 改变时调用-setNeedsDisplay， 重绘视图
 center,            // 图片尺寸不变，与UIImageView中心对齐
 */
        imgv.contentMode = .scaleToFill
        return imgv
    }()
    
    //Tap 轻点
    lazy var tap :UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap))
    }()
    //LongPress长按
    lazy var longPress :UILongPressGestureRecognizer = {
        return UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(longPress:)))
    }()
    //Pinch 捏合
    lazy var pinch :UIPinchGestureRecognizer = {
        return UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(pinch:)))
    }()
    //Rotation 旋转
    lazy var rotation :UIRotationGestureRecognizer = {
        return UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(rotation:)))
    }()
    //Swipe 轻扫
    lazy var swipe :UISwipeGestureRecognizer = {
        return UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(swipe:)))
    }()
    //Pan 平移拖拽
    var startCenter :CGPoint = CGPoint.zero//记录位移偏移量
    lazy var pan :UIPanGestureRecognizer = {
        UIPanGestureRecognizer(target: self, action: #selector(handlePan(pan:)))
    }()
    
    //ScreenEdgePan 屏幕边缘平移
    lazy var screenEdgePan :UIScreenEdgePanGestureRecognizer = {
        let _screenEdgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgePan(screenEdgePan:)))
        _screenEdgePan.edges = .right
        return _screenEdgePan
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "七种手势"
        view.backgroundColor = UIColor.systemRed
        
        
        
        view.addSubview(imageV)
        
        imageV.isUserInteractionEnabled = true//允许有手势的交互
        imageV.addGestureRecognizer(tap)
        imageV.addGestureRecognizer(longPress)
        imageV.addGestureRecognizer(pinch)
        imageV.addGestureRecognizer(rotation)
        imageV.addGestureRecognizer(swipe)
        imageV.addGestureRecognizer(pan)
        imageV.addGestureRecognizer(screenEdgePan)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        imageV.removeGestureRecognizer(tap)
        imageV.removeGestureRecognizer(longPress)
        imageV.removeGestureRecognizer(pinch)
        imageV.removeGestureRecognizer(rotation)
        imageV.removeGestureRecognizer(swipe)
        imageV.removeGestureRecognizer(pan)
        imageV.removeGestureRecognizer(screenEdgePan)
    }
}

extension MyGestrue {
    /* UIGestureRecognizer.State
     0、possible: 识别器在未识别出它的手势，但可能会接收到触摸时处于这个状态。这是默认状态。
     
     1、began: 识别器接收到触摸并识别出是它的手势时处于这个状态。响应方法将在下个循环步骤中被调用。

     2、changed:the recognizer has received touches recognized as a change to the gesture. （不懂怎么翻译，理解上就是识别器识别出一个变化为它的手势的触摸），响应方法将在下个循环步骤中被调用。

     3、ended:识别器在识别到作为当前手势结束信号的触摸时处于这个状态。响应方法将在下个循环步骤中被调用 并且 识别器将重置为possible状态。

     4、cancelled:识别器处于取消状态.响应方法将在下个循环步骤中被调用 并且 识别器将重置为possible状态。

     5、failed: 识别器接收到不能识别为它的手势的一系列触摸。响应方法不会被调用 并且 识别器将重置为possible状态。

     6、recognized: 识别器已识别到它的手势。响应方法将在下个循环步骤中被调用 并且 识别器将重置为possible状态。
     */
    
    func stateTo(_ state :UIGestureRecognizer.State) -> String{
        switch state {
        case .possible: return "possible"
        case .began: return "began"
        case .changed: return "changed"
        case .ended: return "ended"
        case .cancelled: return "cancelled"
        case .failed: return "failed"
        @unknown default:
            return "recognized"
        }
    }
    
    @objc func handleTap(tap: UITapGestureRecognizer) {
        print("\(#function): state = \(stateTo(tap.state))")
        if tap.state == .ended {
            
        }
    }
    
    @objc func handleLongPress(longPress: UILongPressGestureRecognizer) {
        print("\(#function): state = \(stateTo(longPress.state))")
        if longPress.state == .began {
            view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else if longPress.state == .ended {
            view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    
    @objc func handlePinch(pinch: UIPinchGestureRecognizer) {
        print("\(#function): state = \(stateTo(pinch.state)), scale = \(pinch.scale)")
        if pinch.state == .began || pinch.state == .changed {
            imageV.transform = imageV.transform.scaledBy(x: pinch.scale, y: pinch.scale)
            pinch.scale = 1
            //pinch.velocity 缩放速度 放大为正
        }
    }
    
    @objc func handleRotation(rotation: UIRotationGestureRecognizer) {
        print("\(#function): state = \(stateTo(rotation.state)), rotation = \(rotation.rotation)")
        if rotation.state == .began || rotation.state == .changed {
            imageV.transform = imageV.transform.rotated(by: rotation.rotation)
            rotation.rotation = 0.0
            //rotation.velocity 旋转速度 顺时针为正
        }
    }
    
    @objc func handleSwipe(swipe: UISwipeGestureRecognizer) {
        print("\(#function): state = \(stateTo(swipe.state))")
        if swipe.state == .ended {
        }
    }
    
    
    @objc func handlePan(pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: imageV.superview)
        print("\(#function): state = \(stateTo(pan.state)), translation = \(translation)")
//        pan.setTranslation(<#T##translation: CGPoint##CGPoint#>, in: <#T##UIView?#>)设置手指在某个View中的偏移量
//        pan.velocity(in: <#T##UIView?#>)平移速度
        if pan.state == .began {
            startCenter = imageV.center
        }
        if pan.state != .cancelled {
            imageV.center = CGPoint(x: startCenter.x + translation.x, y: startCenter.y + translation.y)
        }
    }
    
    @objc func handleScreenEdgePan(screenEdgePan: UIScreenEdgePanGestureRecognizer) {
        let x = screenEdgePan.translation(in: view).x//在指定视图的坐标系中平移
        print("\(#function): state = \(stateTo(screenEdgePan.state)), x = \(x)")
        if screenEdgePan.state == .began || screenEdgePan.state == .changed {
            imageV.transform = CGAffineTransform(translationX: x, y: 0)
        }else{
            UIView.animate(withDuration: 0.3) {
                self.imageV.transform = .identity
            }
        }
    }
}
