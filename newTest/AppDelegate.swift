//
//  AppDelegate.swift
//  my_swift2
//
//  Created by one on 2020/6/17.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("已经启动，首次执行")
        
        self.window?.rootViewController = UINavigationController(rootViewController: MyTabBarController())
        
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       print("即将入非活动")
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("已经入后台")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("即将入前台")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("已经激活")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("退出")
    }


}

