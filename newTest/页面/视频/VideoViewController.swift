//
//  VideoViewController.swift
//  newTest
//
//  Created by one on 2020/7/9.
//  Copyright © 2020 one. All rights reserved.
//  视频列表首页   左滑进入个人主页
/**
 https://www.jianshu.com/p/5788a840a76b
 https://www.jianshu.com/p/20e5e6d5f3e5 // AVPlayer 详情
 */

import UIKit
import AVKit //AVPlayer


class VideoViewController: BaseViewController {
    
    //视频图层
    lazy var playerView :UIView = {
        let v = UIView(frame: self.view.frame)
        v.backgroundColor = UIColor.systemRed
        return v
    }()
    
    //
    lazy var btnPlay :UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 10, y: 250 - 40, width: 200, height: 30)
        button.setTitle("播放", for: .normal)
        button.backgroundColor = UIColor.green
        button.addTarget(self, action: #selector(btnPlayclik), for: .touchUpInside)
        return button
    }()
    var playerTxt :String? {
        didSet{
            btnPlay.setTitle(playerTxt!, for: .normal)
        }
    }
    
    //切换视频源
    lazy var btnPlayerChange :UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 10, y: 250, width: 200, height: 30)
        button.setTitle("切换视频源", for: .normal)
        button.backgroundColor = UIColor.green
        button.addTarget(self, action: #selector(changeSoure), for: .touchUpInside)
        return button
    }()
    
    
//    lazy var btnpSnapshot :UIButton = {
//        let button = UIButton(type: .system)
//        button.frame = CGRect(x: 10, y: 250 + 40, width: 200, height: 30)
//        button.setTitle("视频快照", for: .normal)
//        button.backgroundColor = UIColor.green
//        button.addTarget(self, action: #selector(btnSnapshot), for: .touchUpInside)
//        return button
//    }()
    
    lazy var imageV:UIImageView={
        let v = UIImageView(frame: CGRect(x: 30, y: 20, width: kScreenW - 40, height: kScreenH-60))
        
        return v
    }()
    
    @objc func changeSoure(){
        changePlayerSoure()
    }
    
    @objc func btnPlayclik(){
        if isPlaying {
            pause()
        }else{
            play()
        }
        
    }
//    @objc func btnSnapshot(){
//
//        if let img = snapshotImage() {
//            imageV.image = img
//            view.addSubview(imageV)
//
//            print("==========")
//        }
//    }
    
    
    
    
    //MARK: - life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        isNavSpecialHidden = true
        
        self.view.addSubview(playerView)
        view.addSubview(btnPlay)
        view.addSubview(btnPlayerChange)
//        view.addSubview(btnpSnapshot)//有问题
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        playerInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.addGestureRecognizer(scrollGes)
        isAddOtherVC = false
        
        addPlayerObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removePlayerObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        view.removeGestureRecognizer(scrollGes)
        
        destroyPlayer()
    }
    
    //MARK: - 视频
    /**
     API:
     https://developer.apple.com/documentation/avfoundation/avasset
     https://developer.apple.com/documentation/avfoundation/avplayeritem
     https://developer.apple.com/documentation/avfoundation/avplayer
     https://developer.apple.com/documentation/avfoundation/avplayerlayer
     */
    
    let urlString = "https://aweme.snssdk.com/aweme/v1/playwm/?s_vid=93f1b41336a8b7a442dbf1c29c6bbc560dd9a0143e0d4b98eedcca615a9f2ed8d64abaa292f0cfad5040ff4b80b7d3927384e96cbab0fc880383bc20e4e2241e&line=0"
    let urlString2 = "https://aweme.snssdk.com/aweme/v1/playwm/?s_vid=93f1b41336a8b7a442dbf1c29c6bbc56847f8d50e69bf1457506e59673c40d5051853318959049f52a0992ce7485eeb447cc499b05bd876cb5815ad215a96681&line=0"
    private var soureIndex = 0
    private var palyerItem :AVPlayerItem!
    private var player :AVPlayer!
    private var playerLayer :AVPlayerLayer!
    private var periodicTimeID :Any?//观察者ID
    private var isCanPlay :Bool = false//当前能否播放
    private var isPlaying :Bool = false
    
    ///初始化播放器
    func playerInit(_ url :String? = nil){
        guard self.player == nil else {
            return
        }
        
        //创建媒体资源管理对象
        if let _url = url {
            soureIndex = 2
            self.palyerItem = AVPlayerItem(url: URL(string: _url)!)
        }else{
            soureIndex = 1
            self.palyerItem = AVPlayerItem(url: URL(string: urlString)!)
        }
        
        
        //创建ACplayer：负责视频播放
        self.player = AVPlayer.init(playerItem: self.palyerItem)
        self.player.rate = 1.0//播放速度 播放前设置
        
        //创建显示视频的图层 
        playerLayer = AVPlayerLayer.init(player: self.player)
        
        //播放器层的边界内如何显示视频 https://developer.apple.com/documentation/avfoundation/avlayervideogravity
        playerLayer.videoGravity = .resizeAspect//
        
//        playerLayer.frame = self.view.bounds
//        self.view.layer.addSublayer(playerLayer)
        //自定义图层
        playerLayer.frame = playerView.bounds
        playerView.layer.addSublayer(playerLayer)
        
//        addPlayerObserver()
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
        isPlaying = true
        self.player.play()
        playerTxt = isPlaying ? "暂停":"播放"
    }
    
    func pause(){
        isPlaying = false
        self.player.pause()
        playerTxt = isPlaying ? "暂停":"播放"
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
        let seekTime = CMTimeMake(value: Int64(0.0), timescale: 1)
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
        print("播放时间：\(loadTime)")
        print("总时间：\(totalTime))")
    }
    
    //MARK: -方法
    ///切换视频源
    func changePlayerSoure(){
        _videoOutput = nil
        removePlayerObserver()
        destroyPlayer()
        if soureIndex == 1 {
            playerInit(urlString2)
            addPlayerObserver()
        }else{
            playerInit()
        }
        
        
    }
    //输出流的地址
    private var _videoOutput :AVPlayerItemVideoOutput?
    ///视频快照
    func snapshotImage() -> UIImage? {
        
        if self._videoOutput == nil {
            self._videoOutput = AVPlayerItemVideoOutput(pixelBufferAttributes: nil)
            palyerItem.remove(self._videoOutput!)
            palyerItem.add(self._videoOutput!)
        }
        
        guard let videoOutput = self._videoOutput else {
            return nil
        }
        //当前正在播放的时间
        let time = videoOutput.itemTime(forHostTime: CACurrentMediaTime())
        guard time.value != 0 else {
            return nil
        }
        if videoOutput.hasNewPixelBuffer(forItemTime: time) {
            let lastSnapshotPixelBuffer = videoOutput.copyPixelBuffer(forItemTime: time, itemTimeForDisplay: nil)
            if lastSnapshotPixelBuffer != nil {
                let ciImage = CIImage(cvPixelBuffer: lastSnapshotPixelBuffer!)
                let context = CIContext(options: nil)
                let rect = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(CVPixelBufferGetWidth(lastSnapshotPixelBuffer!)), height: CGFloat(CVPixelBufferGetHeight(lastSnapshotPixelBuffer!)))
                let cgImage = context.createCGImage(ciImage, from: rect)
                if cgImage != nil {
                    return UIImage(cgImage: cgImage!)
                }
            }
        }
        return nil
    }
    
    
    
    
    
    //MARK: - lazy
    lazy var label :UILabel = {
        let lb = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 30))
        lb.center = self.view.center
        lb.text = "-------------主页-------------"
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
        let vc = OtherPersonalVC()
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
