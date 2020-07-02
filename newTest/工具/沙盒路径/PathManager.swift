//
//  MyPath.swift
//  newTest
//
//  Created by one on 2020/6/29.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit
/*枚举 SearchPathDirectory */
/*
 1，Home目录  ./
    整个应用程序各文档所在的目录
 2，Documnets目录  ./Documents
    用户文档目录，苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
 3，Library目录  ./Library
     这个目录下有两个子目录：Caches 和 Preferences
     Library/Preferences目录，包含应用程序的偏好设置文件。不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好。
     Library/Caches目录，主要存放缓存文件，iTunes不会备份此目录，此目录下文件不会再应用退出时删除
 4，tmp目录  ./tmp
    用于存放临时文件，保存应用程序再次启动过程中不需要的信息，重启后清空。
 5，程序打包安装的目录 NSBundle.mainBundle()
    工程打包安装后会在NSBundle.mainBundle()路径下，该路径是只读的，不允许修改。
    **所以当我们工程中有一个SQLite数据库要使用，在程序启动时，我们可以把该路径下的数据库拷贝一份到Documents路径下，以后整个工程都将操作Documents路径下的数据库。
链接：https://blog.csdn.net/u011598999/article/details/80086909
 */


private let pathMgr = PathManager()
class PathManager {
    class var shared :PathManager {
        return pathMgr
    }
    
    func printPath() {
        print("pHome: \(pHome())")
        print("pDocuments: \(pDocuments())")
        print("pLibrary: \(pLibrary())")
        print("pCaches: \(pCaches())")
        print("ptmp: \(ptmp())")
        print("pBundlePath: \(pBundlePath())")
    }
    
    
    func pHome() -> String {
        let homeDirectory = NSHomeDirectory()
        return homeDirectory
    }
    
    func pDocuments() -> String {
        //方法1
//        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
//            FileManager.SearchPathDomainMask.userDomainMask, true).first!
//        print("documnetPath: \(documentPath)")
        //方法2
        let ducumentPath2 = NSHomeDirectory() + "/Documents"
        return ducumentPath2
    }
    
    func pLibrary() -> String {
        //Library目录－方法1
//        let libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory,
//            FileManager.SearchPathDomainMask.userDomainMask, true).first!
//        print("libraryPath: \(libraryPath)")
        //Library目录－方法2
        let libraryPath2 = NSHomeDirectory() + "/Library"
        return libraryPath2
    }
    ///主要存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出时删除
    func pCaches() -> String {
        //Cache目录－方法1
//        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,
//            FileManager.SearchPathDomainMask.userDomainMask, true).first!
//        print("cachePath: \(cachePath)")
        //Cache目录－方法2
        let cachePath2 = NSHomeDirectory() + "/Library/Caches"
        return cachePath2
    }

    ///用于存放临时文件，保存应用程序再次启动过程中不需要的信息，重启后清空
    func ptmp() -> String {
        //方法1
//        let tmpPath = NSTemporaryDirectory()
//        print("tmpPath: \(tmpPath)")
        //方法2
        let tmpPath2 = NSHomeDirectory() + "/tmp"
        return tmpPath2
    }
    
    func pBundlePath() -> String {
        return Bundle.main.bundlePath
    }
}
