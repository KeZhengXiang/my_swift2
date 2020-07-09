//
//  MyMapController.swift
//  newTest
//
//  Created by one on 2020/7/7.
//  Copyright © 2020 one. All rights reserved.
//  创建名称：从者云集-学习Demo
//  使用高德地图sdk
//  官方： https://lbs.amap.com/api/ios-sdk/summary
//  高的开发平台控制台： https://console.amap.com/dev/key/app
/**
 Podfile 添加
 ######高德地图sdk#######
 pod 'AMap3DMap' #3D地图SDK
 pod 'AMapSearch' #地图SDK搜索功能
 pod 'AMapLocation' #定位SDK
 
 */


import UIKit

import AMapFoundationKit
import MAMapKit


class MyMapController : BaseViewController {
    
    //显示目标位置
    let target :CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 30.66341289038206, longitude: 104.06732055002922)
    
    var manager:CLLocationManager?
    var mapView:MAMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "高德地图SDK"
        view.backgroundColor = UIColor.white
        
        requsetLoction()
        
        ///配置高德 Key 前，添加开启 HTTPS 功能
        AMapServices.shared().enableHTTPS = true
        
        ///添加高德Key  支持iOS 7.0及以上系统。
        AMapServices.shared().apiKey = "dc166c8cfae52ba27423d106d5a9d493"
        
        
        ///实例化地图对象
        mapView = MAMapView(frame: self.view.bounds)
        mapView.delegate = self
        
        //显示定位蓝点
        mapView.showsUserLocation = true
        
//        mapView.userTrackingMode = .follow//显示自身定位的位置
        mapView.centerCoordinate = target//设置显示经纬度
        
        mapView.zoomLevel = 15//缩放级别（默认3-19，有室内地图时为3-20）
        self.view.addSubview(mapView)
        
        ///设置
        let r = MAUserLocationRepresentation()
        r.showsAccuracyRing = true//精度圈是否显示
        r.showsHeadingIndicator = false//是否显示蓝点方向指向
//        r.fillColor = UIColor.red//调整精度圈填充颜色
        
        ///执行设置
        mapView.update(r)
        
        //开启室内地图
        mapView.isShowsIndoorMap = true
        
        //路况
        mapView.isShowTraffic = false
        
        //设置图层
        mapView.mapType = .standard
        
        createControllerUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - 方法
    ///请求定位弹窗
    func requsetLoction(){
        self.manager = CLLocationManager.init()
        manager?.requestWhenInUseAuthorization()
        manager?.requestAlwaysAuthorization()
        manager?.startUpdatingLocation()
    }
    ///添加标注
    func addAnnotation(coordinate:CLLocationCoordinate2D?){
        let pointAnnotation = MAPointAnnotation()
        if let _coordinate = coordinate {
            pointAnnotation.coordinate = _coordinate
        }else{
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: 39.979590, longitude: 116.352792)
        }
//        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: 39.979590, longitude: 116.352792)
        pointAnnotation.title = "方恒国际"
//        pointAnnotation.subtitle = "阜通东大街6号"
        pointAnnotation.subtitle = "经纬度: (\(pointAnnotation.coordinate.latitude), \(pointAnnotation.coordinate.longitude))"
        mapView.addAnnotation(pointAnnotation)
    }
    
    // MARK: - ControllerUI
    var _h :CGFloat = 100
    lazy var btn :UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.roundedRect)
        btn.frame = CGRect(x: kScreenW - 100, y: _h, width: 100, height: 40)
        _h += 50
        btn.setTitle("普通地图", for: .normal)
        btn.backgroundColor = UIColor.systemYellow
        btn.addTarget(self, action: #selector(changeCen(sender:)), for: .touchUpInside)
        btn.tag = 0
        return btn
    }()
    lazy var btn1 :UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.roundedRect)
        btn.frame = CGRect(x: kScreenW - 100, y: _h, width: 100, height: 40)
        _h += 50
        btn.setTitle("卫星地图", for: .normal)
        btn.backgroundColor = UIColor.systemYellow
        btn.addTarget(self, action: #selector(changeCen(sender:)), for: .touchUpInside)
        btn.tag = 1
        return btn
    }()
    lazy var btn2 :UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.roundedRect)
        btn.frame = CGRect(x: kScreenW - 100, y: _h, width: 100, height: 40)
        _h += 50
        btn.setTitle("夜间视图", for: .normal)
        btn.backgroundColor = UIColor.systemYellow
        btn.addTarget(self, action: #selector(changeCen(sender:)), for: .touchUpInside)
        btn.tag = 2
        return btn
    }()
    lazy var btn3 :UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.roundedRect)
        btn.frame = CGRect(x: kScreenW - 100, y: _h, width: 100, height: 40)
        _h += 50
        btn.setTitle("导航视图", for: .normal)
        btn.backgroundColor = UIColor.systemYellow
        btn.addTarget(self, action: #selector(changeCen(sender:)), for: .touchUpInside)
        btn.tag = 3
        return btn
    }()
    lazy var btn4 :UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.roundedRect)
        btn.frame = CGRect(x: kScreenW - 100, y: _h, width: 100, height: 40)
        _h += 50
        btn.setTitle("公交视图", for: .normal)
        btn.backgroundColor = UIColor.systemYellow
        btn.addTarget(self, action: #selector(changeCen(sender:)), for: .touchUpInside)
        btn.tag = 4
        return btn
    }()
    
    lazy var traSwitch :UISwitch = {
        let swt = UISwitch(frame: CGRect(x: kScreenW - 100, y: _h, width: 100, height: 40))
        _h += 50
        swt.addTarget(self, action: #selector(openTra(sender:)), for: .touchUpInside)
//        swt.setOn(true, animated: false)
        return swt
    }()
    
    lazy var label :UILabel = {
        let lb = UILabel(frame: CGRect(x: kScreenW - 150, y: _h, width: 150, height: 40))
        _h += 50
        lb.textAlignment = .right
        lb.backgroundColor = UIColor.systemYellow
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.text = "点击添加标注"
        return lb
    }()
    lazy var label1 :UILabel = {
        let lb = UILabel(frame: CGRect(x: kScreenW - 150, y: _h, width: 150, height: 40))
        _h += 50
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.adjustsFontSizeToFitWidth = true
        lb.backgroundColor = UIColor.systemYellow
        lb.text = "长按目标位置移动到地图中心"
        return lb
    }()
    
    func createControllerUI(){
        self.view.addSubview(btn)
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        self.view.addSubview(btn3)
        self.view.addSubview(btn4)
        self.view.addSubview(traSwitch)
        self.view.addSubview(label)
        self.view.addSubview(label1)
    }
    
    @objc func changeCen(sender: UIButton){
        ///< 普通地图
        ///< 卫星地图
        ///< 夜间视图
        ///< 导航视图
        ///< 公交视图
        print(sender.tag)
        //设置图层
        switch sender.tag {
        case 0: mapView.mapType = .standard
        case 1: mapView.mapType = .satellite
        case 2: mapView.mapType = .standardNight
        case 3: mapView.mapType = .navi
        case 4: mapView.mapType = .bus
        default: break
        }
    }
    
    @objc func openTra(sender: UISwitch){
        mapView.isShowTraffic = sender.isOn
    }
}


extension MyMapController : MAMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MAMapView!) {
        print("地图加载成功")
    }
    func mapViewWillStartLocatingUser(_ mapView: MAMapView!) {
        print("地图开始定位")
    }
    func mapViewDidStopLocatingUser(_ mapView: MAMapView!) {
        let coordinate = mapView.centerCoordinate
        print("地图View停止定位, 经纬度: (\(coordinate.latitude), \(coordinate.longitude))")//
    }
    func mapView(_ mapView: MAMapView!, didFailToLocateUserWithError error: Error!) {
        print("地图定位失败 error = \(error!)")
    }
    
//    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
//        print("位置或者设备方向更新")
//    }
    
    func mapView(_ mapView: MAMapView!, didSingleTappedAt coordinate: CLLocationCoordinate2D) {
        print("点击view经纬度: (\(coordinate.latitude), \(coordinate.longitude))")
        addAnnotation(coordinate: coordinate)
    }
    
    
    //长按地图
    func mapView(_ mapView: MAMapView!, didLongPressedAt coordinate: CLLocationCoordinate2D) {
        mapView.setCenter(coordinate, animated: true)
    }
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKind(of: MAPointAnnotation.self) {
            let pointReuseIndetifier = "pointReuseIndetifier"
            var annotationView: MAAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier)
            
            if annotationView == nil {
                annotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }
            
            annotationView!.canShowCallout = true
//            annotationView!.animatesDrop = true
            annotationView!.isDraggable = true
            annotationView!.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)

            
            annotationView!.image = UIImage(named: "navbar_bg_normal")
            annotationView!.frame.size = CGSize(width: 40, height: 70)
//            annotationView!.backgroundColor = UIColor.white
//            let img = UIImage(named: "navbar_bg_normal")
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView!.centerOffset = CGPoint(x: 0, y: -30);
            
            return annotationView!
        }
        return nil
    }
    
}
