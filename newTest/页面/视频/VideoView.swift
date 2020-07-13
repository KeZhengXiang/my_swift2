//
//  VideoView.swift
//  newTest
//
//  Created by one on 2020/7/13.
//  Copyright © 2020 one. All rights reserved.
//  播放器

import UIKit
import AVKit //AVPlayer

class VideoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("\(self.classForCoder): \(#function)")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(self.classForCoder): \(#function)")
    }
    
    
    //MARK: - 视频
    let cover1 :String = "https://p1.pstatp.com/large/tos-cn-p-0015/86a5a7ee215e4b81b6751edbb02f7cc9_1588413349.jpg"
    let cover2 :String = "https://p1.pstatp.com/large/tos-cn-p-0015/86a5a7ee215e4b81b6751edbb02f7cc9_1588413349.jpg"
//    let cover2 :String = "https://p1.pstatp.com/large/tos-cn-p-0015/0a4c42c89fea4e2e90c072ea4b392e34_1590146886.jpg"
    private lazy var coverImg :UIImageView = {
        let v = UIImageView(frame: self.bounds)
        v.contentMode = .scaleAspectFit
        return v
    }()
    var cover :String?{
        didSet{
            coverImg.kf.setImage(with: URL(string: cover!))
        }
    }
    let urlString = "https://aweme.snssdk.com/aweme/v1/playwm/?s_vid=93f1b41336a8b7a442dbf1c29c6bbc560dd9a0143e0d4b98eedcca615a9f2ed8d64abaa292f0cfad5040ff4b80b7d3927384e96cbab0fc880383bc20e4e2241e&line=0"
    let urlString2 = "https://aweme.snssdk.com/aweme/v1/playwm/?s_vid=93f1b41336a8b7a442dbf1c29c6bbc560dd9a0143e0d4b98eedcca615a9f2ed8d64abaa292f0cfad5040ff4b80b7d3927384e96cbab0fc880383bc20e4e2241e&line=0"
//    let urlString2 = "https://aweme.snssdk.com/aweme/v1/playwm/?s_vid=93f1b41336a8b7a442dbf1c29c6bbc56847f8d50e69bf1457506e59673c40d5051853318959049f52a0992ce7485eeb447cc499b05bd876cb5815ad215a96681&line=0"
    private var soureIndex = 1
    var palyerItem :AVPlayerItem!
    var player :AVPlayer!
    var playerLayer :AVPlayerLayer!
    private var periodicTimeID :Any?//观察者ID
    var isCanPlay :Bool = false//当前能否播放
    
   ///初始化播放器
    func playerInit(){
        guard self.player == nil else {
            return
        }
        
        //创建媒体资源管理对象
        if soureIndex != 2 {
            self.palyerItem = AVPlayerItem(url: URL(string: urlString)!)
        }else{
            self.palyerItem = AVPlayerItem(url: URL(string: urlString2)!)
        }
        
        //创建ACplayer：负责视频播放
        self.player = AVPlayer.init(playerItem: self.palyerItem)
        self.player.rate = 1.0//播放速度 播放前设置
        
        //创建显示视频的图层
        playerLayer = AVPlayerLayer.init(player: self.player)
        
        //播放器层的边界内如何显示视频 https://developer.apple.com/documentation/avfoundation/avlayervideogravity
        playerLayer.videoGravity = .resizeAspect//
        
        playerLayer.frame = self.bounds
        self.layer.addSublayer(playerLayer)
        
//        addPlayerObserver()
        //封面
//        addSubview(coverImg)
//        cover = soureIndex == 1 ? cover1 : cover2
//        coverImg.isHidden = false
    }
    
    ///彻底销毁播放器
    func destroyPlayer(){
        guard self.player != nil else {
            return
        }
//        removePlayerObserver()
        
        //取消和释放挂起的查找的完成处理程序。
        self.player.currentItem?.cancelPendingSeeks()
        //取消为所有观察者加载所有值
        self.player.currentItem?.asset.cancelLoading()
        
        self.playerLayer.removeFromSuperlayer()
        
        self.palyerItem = nil
        self.player = nil
        self.playerLayer = nil
        
    }
    
    func play(){
        guard isCanPlay else {
            return
        }
        self.player.play()
    }
    
    func pause(){
        self.player.pause()
    }
    
    func addPlayerObserver(){
        guard self.player != nil else {
            return
        }
        isCanPlay = true
        play()
        
        self.palyerItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        self.palyerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        self.palyerItem.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        self.palyerItem.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new,context:nil)
        
        addNotification()
        
        periodicTimeID = self.player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main,using: observePeriodicTime(time:))
        
    }
    
    func removePlayerObserver(){
        guard self.player != nil else {
            return
        }
        isCanPlay = false
        
        self.player.pause()
        
        self.palyerItem.removeObserver(self, forKeyPath: "status", context: nil)
        self.palyerItem.removeObserver(self, forKeyPath: "loadedTimeRanges", context: nil)
        self.palyerItem.removeObserver(self, forKeyPath: "playbackBufferEmpty", context: nil)
        self.palyerItem.removeObserver(self,forKeyPath: "playbackLikelyToKeepUp", context: nil)
        
        removeNotification()
        
        //当代码中调用了addPeriodicTimeObserverForInterval方法的时候，还需要释放addPeriodicTimeObserverForInterval返回的playbackObserver对象
        if let id = periodicTimeID {
            self.player.removeTimeObserver(id)
            periodicTimeID = nil
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            switch self.palyerItem.status{
                case .readyToPlay: //准备播放
                    print("status: readyToPlay 准备播放")
                    self.play()
                    
                case .failed: //播放失败
                    print("status: failed")
                case.unknown: //未知情况
                    print("status: unkonwn")
                default: //未知情况2
                    print("status: unkonwn2")
            }
        }else if keyPath == "loadedTimeRanges"{
            let loadTimeArray = self.palyerItem.loadedTimeRanges
            //获取最新缓存的区间
            let newTimeRange : CMTimeRange = loadTimeArray.first as! CMTimeRange
            let startSeconds = CMTimeGetSeconds(newTimeRange.start);
            let durationSeconds = CMTimeGetSeconds(newTimeRange.duration);
            let totalBuffer = startSeconds + durationSeconds;//缓冲总长度
            print("loadedTimeRanges: 当前缓冲时间：\(totalBuffer)")
        }else if keyPath == "playbackBufferEmpty"{
            print("playbackBufferEmpty: 正在缓存视频请稍等")
        }
        else if keyPath == "playbackLikelyToKeepUp"{
            print("playbackLikelyToKeepUp: 缓存好了可继续播放")
            self.play()
        }
    }
    
    /**
     //播放结束
     AVPlayerItemDidPlayToEndTime
     //进行跳转
     AVPlayerItemTimeJumped
     //异常中断通知
     AVPlayerItemPlaybackStalled
     //播放失败
     AVPlayerItemFailedToPlayToEndTime
     */
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(playToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimeJumped), name: NSNotification.Name.AVPlayerItemTimeJumped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playbackStalled), name: NSNotification.Name.AVPlayerItemPlaybackStalled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playFailed), name: NSNotification.Name.AVPlayerItemFailedToPlayToEndTime, object: nil)
        
    }
    func removeNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func playToEndTime(){
        print("notification: 播放完成")
        //重播
        let seekTime = CMTimeMake(value: Int64(0.00001), timescale: 1)
        player.seek(to: seekTime) {[weak self] (bl :Bool) in
            if bl == true {
                self?.play()
            }
        }
    }
    @objc func TimeJumped(){
        print("notification: 进行跳转")
    }
    @objc func playbackStalled(){
        print("notification: 异常中断通知")
    }
    @objc func playFailed(){
        print("notification: 播放失败")
    }
    
    func observePeriodicTime(time :CMTime){
        //当前正在播放的时间
        let loadTime = CMTimeGetSeconds(time)
        //视频总时间
        let totalTime = CMTimeGetSeconds((self.player.currentItem?.duration)!)
//        print("播放时间：\(loadTime)")
//        print("总时间：\(totalTime))")
        if loadTime >= 0.00001 {
            if !coverImg.isHidden {
                frame.origin = CGPoint.zero
            }
            coverImg.isHidden = true
            
        }
    }

    //MARK: -方法
    ///切换视频源
    func changePlayerSoure(){
        removePlayerObserver()
        destroyPlayer()
        soureIndex = soureIndex == 1 ? 2 : 1
        playerInit()
        addPlayerObserver()
        
    }
}
