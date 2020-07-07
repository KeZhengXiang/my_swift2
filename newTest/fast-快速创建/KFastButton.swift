//
//  KFastButton.swift
//  newTest
//
//  Created by one on 2020/7/7.
//  Copyright © 2020 one. All rights reserved.
//  快速按钮

import UIKit


func fastButton(frame :CGRect, title :String) -> UIButton{
    let btn = UIButton(frame: frame)
    btn.setTitle(title, for: .normal)
    
    return btn
}


