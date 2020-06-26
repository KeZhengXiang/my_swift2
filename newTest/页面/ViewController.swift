//
//  ViewController.swift
//  my_swift2
//
//  Created by one on 2020/6/17.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "首页"
        
        //创建返回按钮
        let button:UIButton = UIButton(type: .system)
        button.frame = CGRect(x: 10, y: 150, width: 200, height: 30)
        button.setTitle("进入安全区域测试页面", for: .normal)
        button.addTarget(self,action:#selector(jump),for:.touchUpInside)
        self.view.addSubview(button);
        
        //请求网络数据
        HttpManager.shared.useHttp();
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    //跳转到另一个视图
    @objc func jump(){
        print("点击按钮，开始跳转！")
        let anotherVC = MyCollectionView()
        //1
//        present(anotherVC, animated: true, completion: nil)
        //2
        self.navigationController?.pushViewController(anotherVC, animated: true)
    }

    
    

}
