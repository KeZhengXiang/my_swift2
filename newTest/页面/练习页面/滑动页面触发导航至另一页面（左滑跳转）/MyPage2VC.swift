//
//  MyPage2VC.swift
//  newTest
//
//  Created by one on 2020/7/11.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit


class MyPage2VC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemYellow
        isNavSpecialHidden = true
        
        view.addSubview(label)
    }
    
    
    lazy var label :UILabel = {
        let lb = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 30))
        lb.center = self.view.center
        lb.text = "-------------第二页面-------------"
        lb.textAlignment = .center
        lb.backgroundColor = UIColor.systemBlue
        return lb
    }()
    
}
