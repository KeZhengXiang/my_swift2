//
//  MyCollectionView.swift
//  newTest
//
//  Created by one on 2020/6/26.
//  Copyright © 2020 one. All rights reserved.
//  网格基础使用


import UIKit
import SnapKit

class MyCollectionView: BaseViewController {
    
    var cellw = kScreenW/2 //依据间距调整，当前是0间距
    var cellh = CGFloat(135.0)
    
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "经典网格视图"
        //创建布局模式对象
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0//item左右间隔
        flowLayout.minimumLineSpacing = 0//item上下间隔
        //CollectionView上下左右边距
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //头尾视图容器大小
        flowLayout.headerReferenceSize = CGSize.init(width: kScreenW, height: 100)//
        flowLayout.footerReferenceSize = CGSize.init(width: kScreenW, height: 100)
        
        //设置cell尺寸
        flowLayout.itemSize = CGSize(width: cellw, height: cellh)
        //设置滑动方向
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        //创建UICollectView对象
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //创建重用cell（集合对象是代码生成的而不是NIB或故事板生成的因此需要注册一个UICollectionCell，否则初始化时会发生错误）
        collectionView.register(CustomCVCell.self, forCellWithReuseIdentifier: "CustomCVCell")
        
        //头视图
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "kHeaderViewID")
        //尾视图
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "kFooterViewID")
        self.view.addSubview(collectionView)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
}

extension MyCollectionView : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    //返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCVCell", for: indexPath) as! CustomCVCell
        cell.backgroundColor = kRGB(Int(arc4random_uniform(256)),Int(arc4random_uniform(256)),Int(arc4random_uniform(256)))
        cell.lable?.text = "item\(indexPath.row)"
        return cell
    }
    
    //Section 分区头尾视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var targetView :UICollectionReusableView = UICollectionReusableView()
        if(kind == UICollectionView.elementKindSectionHeader){
            //1.取出section的headerView
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "kHeaderViewID", for: indexPath) as UICollectionReusableView

            let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 100))
            view.backgroundColor = kRGB(Int(arc4random_uniform(256)),Int(arc4random_uniform(256)),Int(arc4random_uniform(256)))
            headerView.addSubview(view)

            let txt = UILabel()
            txt.text = "section头视图"
//            txt.backgroundColor = UIColor.white
            view.addSubview(txt)
            txt.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
            
            targetView = headerView
        }else if(kind == UICollectionView.elementKindSectionFooter){
            //2.取出section的footerView
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "kFooterViewID", for: indexPath) as UICollectionReusableView
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 100))
            view.backgroundColor = kRGB(Int(arc4random_uniform(256)),Int(arc4random_uniform(256)),Int(arc4random_uniform(256)))
            footerView.addSubview(view)
            
            let txt = UILabel()
            txt.text = "section尾视图"
//            txt.backgroundColor = UIColor.white
            view.addSubview(txt)
            txt.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
            targetView = footerView
        }
        return targetView
        
    }
}

extension MyCollectionView : UICollectionViewDelegate{

    
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
