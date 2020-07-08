//
//  MyPageViewController.swift
//  newTest
//
//  Created by one on 2020/7/3.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit
 
class MyPageViewController: UIPageViewController {
     
    //MARK: - 初始化
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        // .scroll滑动style  .horizontal 水平style
        super.init(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - life
    
    private var selectIndex = 0
    private var isAnimation = false
    
    //所有页面的视图控制器
    private(set) lazy var allViewControllers: [UIViewController] = {
        return [MyDevice(),MyAnimation(),MyCollectionView()]
    }()
    
    private(set) lazy var btnMove: UIButton = {
        let btn = UIButton(frame: CGRect(x: 100, y: 200, width: 120, height: 40))
        btn.center = self.view.center
        btn.backgroundColor = UIColor.systemBlue
        btn.setTitle("动画切换", for: .normal)
        return btn
    }()
    
    //页面加载完毕
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(btnMove)
        btnMove.addTarget(self, action: #selector(changePageForAnimation(btn:)), for: .touchUpInside)
        
         
        //数据源设置
        dataSource = self
        delegate = self
         
        selectIndex = 0
        //设置首页
        if let firstViewController = allViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        
    }
    
    
    ///
    @objc func changePageForAnimation(btn :UIButton){
        guard !self.isAnimation else{
            return
        }
        isAnimation = true
        selectIndex += 1
        selectIndex = (selectIndex >= allViewControllers.count) ? 0 : selectIndex
        self.setViewControllers([allViewControllers[selectIndex]], direction: UIPageViewController.NavigationDirection.forward, animated: true) {[weak self] (bl) in
            guard self != nil else{
                return
            }
            self!.isAnimation = false
        }
    }
    
    
    
}
extension MyPageViewController : UIPageViewControllerDataSource {
    //获取前一个页面
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore
                            viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = allViewControllers.firstIndex(of: viewController) else {
            return nil
        }
         
        let previousIndex = viewControllerIndex - 1
        selectIndex = previousIndex
        print("----go selectIndex = \(selectIndex)")
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
        selectIndex = nextIndex
        print("----go selectIndex = \(selectIndex)")
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
