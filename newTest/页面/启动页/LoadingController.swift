//
//  LoadingController.swift
//  newTest
//
//  Created by one on 2020/7/8.
//  Copyright © 2020 one. All rights reserved.
//

import Foundation
import UIKit


class LoadingController :BaseViewController {
    
    
    
    lazy var btnGoHome:UIButton = {
        let btn = UIButton(frame: CGRect(x: kScreenW - 100, y: kStatusBarHeight, width: 100, height: 30))
        btn.backgroundColor = kRGB(66, 66, 66, 0.4)
        btn.setTitle("倒计时", for: .normal)
        btn.tag = 0
        btn.layer.cornerRadius = 15//圆角
        return btn
    }()
    
    
//    lazy var backImageView :UIImageView = {
//        let img = UIImageView()
//        return img
//    }()
    
    lazy var ban :BannerView = {
        let v = BannerView(frame: view.frame)
        v.setImages(images: ["backImage0","navbar_bg_normal"]) { (index :Int) in
            print("index = \(index)")
        }
        v.isPageControlHide(isHidden: true)
//        if(isLiuHaiScreen){
//            v.pageControlPos(center: CGPoint(x:v.frame.width/2,y:v.frame.height - CGFloat(15 + kBottomSafeHeight)))
//        }else{
//            v.pageControlPos(center: CGPoint(x:v.frame.width/2,y:v.frame.height - CGFloat(15 + kBottomSafeHeight)))
//        }
        v.clickBlock = {index in
            print("===========index :\(index)")
        }
        return v
    }()
    
    
    //MARK:-life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(ban)
        view.addSubview(btnGoHome)
        
        btnGoHome.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        
        openTimer()
        printViewParam()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        closeTimer()
    }
    
    //MARK:-func
    @objc func goHome(){
        guard btnGoHome.tag == 1 else {
            return
        }
        self.navigationController?.pushViewController(MyTabBarController(), animated: true)
        
    }
    //MARK:- 定时器  RunLoop

    private var timer:Timer?
    private var curTime :Double = 3
    func openTimer(){
        btnGoHome.setTitle("\(Int(curTime))秒", for: .normal)
        btnGoHome.tag = 0
        if(timer == nil){
            let interval:Double = 1
             timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(startAutoScroll), userInfo: nil, repeats: true)
        }
    }
     
    func closeTimer(){
        if(timer != nil){
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc func startAutoScroll(){
        if(self.view.window != nil){
            curTime -= 1
            //update
            if (curTime < 0){
                closeTimer()
                btnGoHome.setTitle("进入", for: .normal)
                btnGoHome.tag = 1
            }else{
                btnGoHome.setTitle("\(Int(curTime))秒", for: .normal)
            }
        }
    }
    
}
