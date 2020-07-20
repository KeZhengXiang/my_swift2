//
//  videoTableVC.swift
//  newTest
//
//  Created by one on 2020/7/13.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit


class videoTableVC: BaseViewController {
    
    
    private var models :[VideoModel] = []
    
    private var idx :Int = 0
    private var videoView :VideoView!
    
    private var tableview :UITableView!
    private var endy :CGFloat = 0.0//滑动结束记录y坐标
    private var beginD :Bool = true//是否手势向下滑动  页面向上滑
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isNavSpecialHidden = true
        
        HttpManager.shared.readVideos()
        
        for _ in 0..<100 {
            models.append(VideoModel())
        }
        
        self.tableview = UITableView.init(frame: self.view.frame, style: .plain)
        
        self.view.addSubview(tableview)
        //注册
        tableview.register(VideoTableCell.self, forCellReuseIdentifier: "cell")
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        //
        self.tableview.rowHeight = view.bounds.height
        
        //干掉 t安保安全区
        if #available(iOS 11.0, *) {
            tableview.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableview.showsHorizontalScrollIndicator = false
        tableview.showsVerticalScrollIndicator = false
        
        // 启动分页（超级重要）
        tableview.isPagingEnabled = true
        
        
        ///播放器
        videoView = VideoView(frame: view.bounds)
        view.addSubview(videoView)
        videoView.isUserInteractionEnabled = false
     
        idx = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        videoView.playerInit()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        videoView.addPlayerObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        videoView.removePlayerObserver()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        videoView.destroyPlayer()
    }

}


extension videoTableVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("重用：\(indexPath)")
        //重用
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VideoTableCell
        cell.model = models[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height
    }
    
}

extension videoTableVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if endy == 0.0 || scrollView.contentOffset.y >= endy {
            beginD = false
        }else{
            beginD = true
        }
        let _idx = Int(scrollView.contentOffset.y/view.bounds.height)
        let _y = -(scrollView.contentOffset.y - CGFloat(beginD ? _idx + 1: _idx) * view.bounds.height)
//        print("\(scrollView.contentOffset),_idx = \(_idx) _y = \(_y)  beginD = \(beginD)")
        videoView.frame.origin = CGPoint(x: 0, y: _y)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let _idx = Int(scrollView.contentOffset.y/view.bounds.height)
//        print("\(#function)  _idx = \(_idx)")
        guard idx != _idx else {
            videoView.frame.origin = CGPoint(x: scrollView.contentOffset.x, y: 0)
            return
        }
        idx = _idx
        endy = scrollView.contentOffset.y
        videoView.changePlayerSoure()
        
    }
}

