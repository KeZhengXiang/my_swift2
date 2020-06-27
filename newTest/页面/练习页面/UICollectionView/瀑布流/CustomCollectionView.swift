//
//  CustomCollectionView.swift
//  newTest
//
//  Created by one on 2020/6/26.
//  Copyright © 2020 one. All rights reserved.
//  自定义布局网格  瀑布流

import UIKit
import SnapKit

class CustomCollectionView: UIViewController {
    
    
    var collectionView : UICollectionView!
    var data: Array<CGSize> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "瀑布流"
        //创建布局模式对象
        let flowLayout = WaterFlow()
        flowLayout.minimumInteritemSpacing = 0//item左右间隔
        flowLayout.minimumLineSpacing = 0//item上下间隔
        //CollectionView上下左右边距
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        for _ in 0...18 {
            data.append(CGSize(width: 90 + Int(arc4random_uniform(50)), height: 150 + Int(arc4random_uniform(40)) ) )
        }
        
        flowLayout.layout(dataA: data, columns: 2)
        
        //设置滑动方向
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        //创建UICollectView对象
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.gray
        //创建重用cell（集合对象是代码生成的而不是NIB或故事板生成的因此需要注册一个UICollectionCell，否则初始化时会发生错误）
        collectionView.register(CustomCVCell.self, forCellWithReuseIdentifier: "CustomCVCell")
        self.view.addSubview(collectionView)
    
    }
}

extension CustomCollectionView : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    //返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCVCell", for: indexPath) as! CustomCVCell
        cell.backgroundColor = kRGB(Int(arc4random_uniform(256)),Int(arc4random_uniform(256)),Int(arc4random_uniform(256)))
        cell.lable?.text = "item\(indexPath.row)"
        return cell
    }
    
    
}

extension CustomCollectionView : UICollectionViewDelegate{

    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("didDeselectItemAt \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        print("didBeginMultipleSelectionInteractionAt \(indexPath)")
    }

    
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionViewDidEndMultipleSelectionInteraction(_ collectionView: UICollectionView) {
        print("collectionViewDidEndMultipleSelectionInteraction")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt \(indexPath)")
    }
    
    
}
