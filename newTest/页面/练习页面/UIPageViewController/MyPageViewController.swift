//
//  MyPageViewController.swift
//  newTest
//
//  Created by one on 2020/7/3.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit
 
class MyPageViewController: UIPageViewController, UIPageViewControllerDataSource {
     
    //所有页面的视图控制器
    private(set) lazy var allViewControllers: [UIViewController] = {
        return [MyDevice(),MyAnimation(),MyCollectionView()]
    }()
     
    //页面加载完毕
    override func viewDidLoad() {
        super.viewDidLoad()
         
        //数据源设置
        dataSource = self
        delegate = self
         
        //设置首页
        if let firstViewController = allViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    //获取前一个页面
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore
                            viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = allViewControllers.firstIndex(of: viewController) else {
            return nil
        }
         
        let previousIndex = viewControllerIndex - 1
         
        guard previousIndex >= 0 else {
            return nil
        }
         
        guard allViewControllers.count > previousIndex else {
            return nil
        }
         
        return allViewControllers[previousIndex]
    }
     
    //获取后一个页面
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter
                            viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = allViewControllers.lastIndex(of: viewController) else {
            return nil
        }
         
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = allViewControllers.count
         
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
         
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
         
        return allViewControllers[nextIndex]
    }
    
}


extension MyPageViewController : UIPageViewControllerDelegate {
    //页面切换完毕
    func pageViewController(pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                                               previousViewControllers: [UIViewController],
                                               transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = allViewControllers.firstIndex(of: firstViewController) {
            print("页面切换完毕:\(index)")
        }
    }
}
