//
//  BannerView.swift
//  newTest
//
//  Created by one on 2020/7/8.
//  Copyright © 2020 one. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


/// 轮播图
class BannerView: UIView, UIScrollViewDelegate{
     
    enum ImageType{
        case Image     //本地图片
        case URL       //URL
    }
     
    //图片水平放置到scrollView上
    private var scrollView:UIScrollView = UIScrollView()
    //小圆点标识
    private var pageControl:UIPageControl = UIPageControl()
 
    
    private var first_image:UIImageView = UIImageView()//左边视图
    private var center_image:UIImageView = UIImageView()//中间视图
    private var second_image:UIImageView = UIImageView()//右边视图
    
    private var tap_center_image:UITapGestureRecognizer!
    //图片集合
    private var images:Array<String> = []
    private var type:ImageType = .Image
     
    private var width:CGFloat = 0
    private var height:CGFloat = 0
     
    private var currIndex = 0
    open var clickBlock :(Int)->Void = {index in}
     
    private var timer:Timer?
     
    // 默认自动播放 设置为false只能手动滑动
    var isAuto = true
    // 轮播间隔时间 默认4秒可以自己修改
    var interval:Double = 4
     
//    override func layoutSubviews() {
//        super.layoutSubviews()
////        self.initLayout()
//    }
    
    deinit {
        center_image.removeGestureRecognizer(tap_center_image)
        closeTimer()
        print("销毁 BannerView")
    }
     
    public func setImages(images:Array<String>,type:ImageType = .Image,imageClickBlock:@escaping (Int) -> Void) {
        self.type = type
        self.images = images
        self.clickBlock = imageClickBlock
        self.initLayout()
    }
     
    private func initLayout(){
        if(self.images.count == 0){
            return
        }
         
        width = frame.size.width
        height = frame.size.height
         
        scrollView.frame = self.bounds
        scrollView.contentSize = CGSize(width:width * CGFloat(3),height:height)
        scrollView.contentOffset = CGPoint(x:width,y:0)//初始偏移到center
        scrollView.isUserInteractionEnabled = true
        scrollView.isPagingEnabled = true//是否为滚动视图启用分页
        scrollView.showsHorizontalScrollIndicator = false//水平滚动指示器是否可见
        scrollView.showsVerticalScrollIndicator = false
//        scrollView.isDirectionalLockEnabled = true
        scrollView.delegate = self
        addSubview(scrollView)
         
        first_image.frame = CGRect(x:0,y:0,width:width,height:height)
        first_image.contentMode = .scaleToFill
        first_image.isUserInteractionEnabled = true
        scrollView.addSubview(first_image)
         
        center_image.frame = CGRect(x:width,y:0,width:width,height:height)
        center_image.contentMode = .scaleToFill
        center_image.isUserInteractionEnabled = true
        scrollView.addSubview(center_image)
         
        second_image.frame = CGRect(x:width * 2.0,y:0,width:width,height:height)
        second_image.contentMode = .scaleToFill
        second_image.isUserInteractionEnabled = true
        scrollView.addSubview(second_image)
        
        pageControl.center = CGPoint(x:width/2,y:height - CGFloat(15))
        pageControl.isEnabled = true
        pageControl.numberOfPages = images.count
        pageControl.currentPageIndicatorTintColor = UIColor.green
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.isUserInteractionEnabled = false
        addSubview(pageControl)
         
        //当前显示的只有 center_image 其他两个只是用来增加滑动时效果而已，不需要添加点击事件
//        addTapGesWithImage(image: center_image)
        tap_center_image = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        center_image.isUserInteractionEnabled = true //让控件可以触发交互事件
        center_image.contentMode = .scaleToFill
        center_image.clipsToBounds = true //超出父控件的部分不显示
        center_image.addGestureRecognizer(tap_center_image)
        if(isAuto){
            openTimer()
        }
        setCurrent(currIndex: 0)
    }
    
    
    open func pageControlPos(center :CGPoint){
        pageControl.center = center
    }
    open func isPageControlHide(isHidden :Bool){
        pageControl.isHidden = isHidden
    }
    
    
    /// 切换
    /// - Parameter currIndex: 目标索引
    func setCurrent(currIndex:Int) {
        //func setContentOffset(CGPoint, animated: Bool)
//        设置与接收者原点相对应的内容视图原点的偏移量。
        
        
        self.currIndex = currIndex
         
        if(type == .Image){
            center_image.image = UIImage.init(named:images[currIndex])
            first_image.image = UIImage.init(named:images[(currIndex - 1 + images.count) % images.count])
            second_image.image = UIImage.init(named:images[(currIndex + 1) % images.count])
        }else{
            center_image.setMyImage(URL: NSURL(string: images[currIndex]))
            first_image.setMyImage(URL: NSURL(string: images[(currIndex - 1 + images.count) % images.count]))
            second_image.setMyImage(URL: NSURL(string: images[(currIndex + 1) % images.count]))
        }
        center_image.tag = currIndex
        pageControl.currentPage = currIndex
        scrollView.setContentOffset(CGPoint(x:width,y:0), animated: false)
    }
     
     
    //点击图片，调用block
    @objc func tap(_ ges:UITapGestureRecognizer) {
        clickBlock((ges.view?.tag)!)
        print("scrollView.contentSize = \(scrollView.contentSize)")
        print("scrollView.frame = \(scrollView.frame)")
        print("scrollView.contentInset = \(scrollView.contentInset)")
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //另类禁用竖直滑动
        scrollView.contentOffset.y = 0
    }
     
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        closeTimer()
    }
     
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        openTimer()
    }
     
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        
        if(scrollView.contentOffset.x > 0){
            currIndex = (currIndex + 1) % images.count
        }else{
            currIndex = (currIndex - 1 + images.count) % images.count
        }
        setCurrent(currIndex: currIndex)
    }
     
    func openTimer(){
        if(isAuto){
            if(timer == nil){
                 timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(startAutoScroll), userInfo: nil, repeats: true)
            }
             
        }
    }
     
    func closeTimer(){
        if(timer != nil){
            timer?.invalidate()
            timer = nil
        }
    }
     
     
    @objc func startAutoScroll(){
        if(isDisplayInScreen()){
            setCurrent(currIndex: (currIndex + 1) % images.count)
        }
    }
     
    func isDisplayInScreen() -> Bool{
        if(self.window == nil){
            return false
        }
        return true
    }
     
}

extension UIImageView{
    // Kingfisher的覆盖  好处：1.不用所有界面都去导入 2.如果KingfisherAPI更新或者更换图片加载库可以更方便一些，保持方法名和第一个参数不变，修改一下就能达到目的，比如修改为使用SDWebImage
    public func setMyImage(URL: NSURL?,placeholderImage: Image? = nil,
                                  optionsInfo: KingfisherOptionsInfo? = nil,
                                  progressBlock: DownloadProgressBlock? = nil,
                                  completionHandler: CompletionHandler? = nil){
        kf.setImage(with: URL as? Resource,
                           placeholder: placeholderImage,
                           options: optionsInfo,
                                  progressBlock: progressBlock,
                                  completionHandler: completionHandler)
        
    }
}

