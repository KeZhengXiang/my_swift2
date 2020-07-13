//
//  MyPage1VC.swift
//  newTest
//
//  Created by one on 2020/7/11.
//  Copyright © 2020 one. All rights reserved.
//  滑动页面触发导航至另一页面（左滑跳转）

import UIKit


class MyPage1VC: BaseViewController {
    
    //MARK: - life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.green
        isNavSpecialHidden = true
        
        view.addSubview(label)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.addGestureRecognizer(scrollGes)
        isAddOtherVC = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        view.removeGestureRecognizer(scrollGes)
        
    }
    
    //MARK: - lazy
        lazy var label :UILabel = {
            let lb = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 30))
            lb.center = self.view.center
            lb.text = "-------------第一页面-------------"
            lb.textAlignment = .center
            lb.backgroundColor = UIColor.cyan
            return lb
        }()
    //    lazy var btnJump :UIButton = {
    //        let button = UIButton(type: .system)
    //        button.frame = CGRect(x: 10, y: 150, width: 200, height: 30)
    //        button.center = view.center
    //        button.setTitle("点击", for: .normal)
    //        button.backgroundColor = UIColor.systemYellow
    //        button.addTarget(self, action: #selector(jump), for: .touchUpInside)
    //        return button
    //    }()
    //
    //    @objc func jump(){
    //        self.navigationController?.pushViewController(otherVC, animated: true)
    //    }
        
        
        //MARK: - 左滑切换到他人主页
        
        // 原始位置
        private let otherViewX :CGFloat = kScreenW
        //滑动容错
        private var scrollX :CGFloat = 0
        private var isAddOtherVC :Bool = false
        
        private var otherVC :BaseViewController = {
            let vc = MyPage2VC()
            return vc
        }()
        
        ///只会执行一次
        func addOtherVC(){
            guard !isAddOtherVC else {
                return
            }
            isAddOtherVC = true
            otherVC.view.frame.origin = CGPoint(x: kScreenW, y: 0)
            self.view.addSubview(otherVC.view)
        }
        func removeOtherVC(){
            if(isAddOtherVC){
                isAddOtherVC = false
                otherVC.view.removeFromSuperview()
            }
        }
        
        //屏幕边缘平移
        lazy var scrollGes :UIPanGestureRecognizer = {
            let pan = UIPanGestureRecognizer(target: self, action: #selector(handle(gestrue:)))
            return pan
        }()
        
        @objc func handle(gestrue: UIPanGestureRecognizer) {
            let x = scrollGes.translation(in: view).x//在指定视图的坐标系中平移
            guard x <= 0 else {//向右滑 禁掉
                return
            }
    //        print("\(#function): state = \(screenEdgePan.state), x = \(x)")
            
            if gestrue.state == .began || gestrue.state == .changed {
                view.transform = CGAffineTransform(translationX: x/2, y: 0)
                if(abs(x) >= scrollX){
                    addOtherVC()
                    otherVC.view.transform = CGAffineTransform.identity
    //                .translatedBy(x: otherViewX + x - x/2, y: 0)//平移  有问题
                    otherVC.view.frame.origin = CGPoint(x: otherViewX + x - x/2, y: 0)
    //                print("--a: \(x/2), a+ :\(view.frame.minX), b: \(otherViewX + x - x/2), b+:\(otherVC.view.frame.minX)")
                }
            }else if gestrue.state == .ended{
                if(abs(x) >= kScreenW/2){
                    let offsetX :CGFloat = -kScreenW
                    UIView.animate(withDuration: 0.1, animations: {
                        [weak self] in
                        guard self != nil else{return}
                        self!.view.transform = CGAffineTransform(translationX: offsetX/2, y: 0)
    //                    self!.otherVC.view.transform = CGAffineTransform(translationX: self!.otherViewX + offsetX/2, y: 0)
                        self!.otherVC.view.frame.origin = CGPoint(x: self!.otherViewX + offsetX/2, y: 0)
                    }) { [weak self] (isOK :Bool) in
                        guard self != nil else{return}
                        if(isOK){
                            //还原视图 静默跳转导航
                            self!.view.transform = .identity
                            self!.removeOtherVC()
                            
//                            let vc = MyPage2VC() //self!.otherVC
//                            vc.view = self!.otherVC.view
                            
                            self!.navigationController?.pushViewController(self!.otherVC, animated: false)
                        }
                    }
                }else{//弹回
                    UIView.animate(withDuration: 0.1) {[weak self] in
                        guard self != nil else{return}
                        self!.view.transform = .identity
    //                    self!.otherVC.view.transform = .identity
                        self!.otherVC.view.frame.origin = CGPoint(x: self!.otherViewX, y: 0)
                    }
                }
            }
        }
}
