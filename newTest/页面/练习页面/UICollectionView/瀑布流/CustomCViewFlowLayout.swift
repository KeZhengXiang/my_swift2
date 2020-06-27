//
//  CustomCViewFlowLayout.swift
//  newTest
//
//  Created by one on 2020/6/26.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit


class CustomCViewFlowLayout: UICollectionViewFlowLayout {
    lazy var dataArray:Array<CGSize> = []
    lazy var attrArray:NSMutableArray = NSMutableArray()
    var lie:Int = 0//列数
    lazy var framYArray = [CGFloat](repeating:self.sectionInset.top, count: lie)//每列迭代Y值
    
    
    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func layout (dataA:Array<CGSize>, columns:Int) {
        self.dataArray = dataA
        self.lie = columns
    }
    
    override func prepare() {
        for i in 0..<self.dataArray.count {
            let indexpath = IndexPath(item: i, section: 0)
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexpath)
        //计算每个宽度
            let allwidth = (self.collectionView?.bounds.size.width)!
            let marginleft = self.sectionInset.left
            let marginRight = self.sectionInset.right
            let totalMargin:CGFloat = ((CGFloat)(lie - 1) * self.minimumInteritemSpacing)
            let itemw:CGFloat = (allwidth - marginRight - marginleft - totalMargin) / (CGFloat)(lie)
            //计算每个高度
            let size:CGSize = self.dataArray[i]
            let itemh:CGFloat = CGFloat(size.height * itemw) / CGFloat(size.width)
            
        //计算每个X
            //计算当前cell是第几列
            let colunm = self.getMinYoftheframeY(frameYArray: self.framYArray)
           
            let itemX = marginleft + (self.minimumInteritemSpacing + itemw) * (CGFloat)(colunm)
            
        
            
        
            //取出当前的列数的Y值
            let itemY = self.framYArray[colunm]
             attrs.frame = CGRect(x: itemX, y: itemY, width: itemw, height: itemh)
            self.framYArray[colunm] = self.framYArray[colunm] + itemh + self.minimumLineSpacing
            self.attrArray.add(attrs)
            
        }
        
        
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
       
        return self.attrArray as? [UICollectionViewLayoutAttributes]
    }
    
    override var collectionViewContentSize: CGSize{
        //假设数组的第一列值最大
        var maxY = self.framYArray[0];
        for i in 0 ..< self.framYArray.count {
            if(maxY<self.framYArray[i]){
                maxY = self.framYArray[i]
            }
        }
      return CGSize(width: (self.collectionView?.bounds.size.width)!, height: maxY)
        
    }

    //计算那列的最大Y值最小
    func getMinYoftheframeY(frameYArray:[CGFloat])->(Int){
        //假设第0列的最大Y值最小
       var minIndex:Int = 0
        var minY = frameYArray[minIndex]
        for u in 0 ..< frameYArray.count {
            if(minY > frameYArray[u]){
                minY = frameYArray[u]
               minIndex = u
            }
            
        }
        return minIndex
    }
    
}





class WaterFlow: UICollectionViewFlowLayout {
   lazy var dataArray:Array<CGSize> = []
   lazy var attrArray:NSMutableArray = NSMutableArray()
   var lie:Int = 0
   lazy var framYArray = [CGFloat](repeating: self.sectionInset.top, count: lie)
    
    
    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   func layout (dataA:Array<CGSize>,columns:Int) {
    
    self.dataArray = dataA
    self.lie = columns
    
    }
    override func prepare() {
        
        
        
        
        for i in 0..<self.dataArray.count {
            let indexpath = IndexPath(item: i, section: 0)
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexpath)
        //计算每个宽度
            let allwidth = (self.collectionView?.bounds.size.width)!
            let marginleft = self.sectionInset.left
            let marginRight = self.sectionInset.right
            let totalMargin:CGFloat = ((CGFloat)(lie - 1) * self.minimumInteritemSpacing)
            let itemw:CGFloat = (allwidth - marginRight - marginleft - totalMargin) / (CGFloat)(lie)
            //计算每个高度
            let model:CGSize = self.dataArray[i]
            let itemh  = (CGFloat)( model.height) * itemw / (CGFloat)(model.width)
        //计算每个X
            //计算当前cell是第几列
            let colunm = self .getMinYoftheframeY(frameYArray: self.framYArray)
           
            let itemX = marginleft + (self.minimumInteritemSpacing + itemw) * (CGFloat)(colunm)
            
        
            
        
            //取出当前的列数的Y值
            let itemY = self.framYArray[colunm]
             attrs.frame = CGRect(x: itemX, y: itemY, width: itemw, height: itemh)
              self.framYArray[colunm] = self.framYArray[colunm] + itemh + self.minimumLineSpacing
              self.attrArray.add(attrs)
            
            
            
        }
        
        
        
        
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
       
        return self.attrArray as? [UICollectionViewLayoutAttributes]
    }
    
    override var collectionViewContentSize: CGSize{
        //假设数组的第一列值最大
        var maxY = self.framYArray[0];
        for i in 0 ..< self.framYArray.count {
            if(maxY<self.framYArray[i]){
                maxY = self.framYArray[i]
            }
        }
        
        
      return CGSize(width: (self.collectionView?.bounds.size.width)!, height: maxY)
        
        
        
    }

    //计算那列的最大Y值最小
    func getMinYoftheframeY(frameYArray:[CGFloat])->(Int){
        
        //假设第0列的最大Y值最小
       var minIndex:Int = 0
        var minY = frameYArray[minIndex]
        for u in 0 ..< frameYArray.count {
            if(minY > frameYArray[u]){
                minY = frameYArray[u]
               minIndex = u
            }
            
        }
        return minIndex
        
        
    }
    
}
