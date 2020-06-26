//
//  RefreshView.swift
//  newTest
//
//  Created by one on 2020/6/21.
//  Copyright © 2020 one. All rights reserved.
//  自定义下拉刷新控件

import UIKit
import MJRefresh

class RefreshView: MJRefreshHeader {
    
    // 转圈的菊花
    var loadingView: UIActivityIndicatorView?
    // 下拉的icon
    var arrowImage: UIImageView?
    /*
     /** 普通闲置状态 */
     MJRefreshStateIdle = 1,
     /** 松开就可以进行刷新的状态 */
     MJRefreshStatePulling,
     /** 正在刷新中的状态 */
     MJRefreshStateRefreshing,
     /** 即将刷新的状态 */
     MJRefreshStateWillRefresh,
     /** 所有数据加载完毕，没有更多的数据了 */
     MJRefreshStateNoMoreData*/
    // 处理不同刷新状态下的组件状态
    override var state: MJRefreshState {
        didSet {
            switch state {
            case .idle:
                self.loadingView?.isHidden = true
                self.arrowImage?.isHidden = false
                self.loadingView?.stopAnimating()
            case .pulling:
                self.loadingView?.isHidden = false
                self.arrowImage?.isHidden = true
                self.loadingView?.startAnimating()
            case .refreshing:
                self.loadingView?.isHidden = false
                self.arrowImage?.isHidden = true
                self.loadingView?.startAnimating()
            default:
                print("")
            }
        }
    }
    
    // 初始化组件
    override func prepare() {
        super.prepare()
        self.mj_h = 50
        
        self.loadingView = UIActivityIndicatorView(style: .gray)
        self.arrowImage = UIImageView(image: UIImage(named: "ic_arrow_downward"))//navbar_bg_normal
        self.addSubview(loadingView!)
        self.addSubview(arrowImage!)
        
    }
    
    // 组件定位
    override func placeSubviews() {
        super.placeSubviews()
        self.loadingView?.center = CGPoint(x: self.mj_w / 2, y: self.mj_h / 2)
        self.arrowImage?.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        self.arrowImage?.center = self.loadingView!.center
    }
    
}
