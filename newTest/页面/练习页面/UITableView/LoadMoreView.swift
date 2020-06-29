//
//  LoadMoreView.swift
//  newTest
//
//  Created by one on 2020/6/21.
//  Copyright © 2020 one. All rights reserved.
//  自定义上拉加载控件

import UIKit
import MJRefresh

class LoadMoreView: MJRefreshAutoFooter {
    
    var loadingView: UIActivityIndicatorView?
    var stateLabel: UILabel?
    
    override var state: MJRefreshState {
        /*/** 普通闲置状态 */
        MJRefreshStateIdle = 1,
        /** 松开就可以进行刷新的状态 */
        MJRefreshStatePulling,
        /** 正在刷新中的状态 */
        MJRefreshStateRefreshing,
        /** 即将刷新的状态 */
        MJRefreshStateWillRefresh,
        /** 所有数据加载完毕，没有更多的数据了 */
        MJRefreshStateNoMoreData*/
        didSet {
            print(state)
            switch state {
            case .idle:
                self.stateLabel?.text = nil
                self.loadingView?.isHidden = true
                self.loadingView?.stopAnimating()
            case .refreshing:
                self.stateLabel?.text = nil
                self.loadingView?.isHidden = false
                self.loadingView?.startAnimating()
            case .noMoreData:
                self.stateLabel?.text = "没有更多数据了"
                self.loadingView?.isHidden = true
                self.loadingView?.stopAnimating()
            default: break
            }
        }
    }
    
    override func prepare() {
        super.prepare()
        self.mj_h = 50
        
        self.loadingView = UIActivityIndicatorView(style: .gray)
        self.stateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        self.stateLabel?.textAlignment = .center
        self.stateLabel?.font = UIFont.systemFont(ofSize: 12)
        
        self.addSubview(loadingView!)
        self.addSubview(stateLabel!)
        
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        self.loadingView?.center = CGPoint(x: self.mj_w / 2, y: self.mj_h / 2)
        self.stateLabel?.center = CGPoint(x: self.mj_w / 2, y: self.mj_h / 2)
    }
    
    
    
}
