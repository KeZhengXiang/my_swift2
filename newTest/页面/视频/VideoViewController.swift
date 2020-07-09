//
//  VideoViewController.swift
//  newTest
//
//  Created by one on 2020/7/9.
//  Copyright © 2020 one. All rights reserved.
//  视频
/**
 https://www.jianshu.com/p/5788a840a76b
 */

import UIKit


class VideoViewController: BaseViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.green
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    
}
