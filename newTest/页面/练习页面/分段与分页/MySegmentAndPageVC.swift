//
//  MySegmentAndPageVC.swift
//  newTest
//
//  Created by one on 2020/7/19.
//  Copyright © 2020 one. All rights reserved.


import UIKit
 
class MySegmentAndPageVC: BasePageViewController, UICollectionViewDelegate {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
//        isNavSpecialHidden = true
        
        createSegmentedControl()
        
        createcollectionView()
        
    }
    
    //MARK:- UISegmentedControl
    var segmented:UISegmentedControl!
    func createSegmentedControl(){
        //选项除了文字还可以是图片
        let items = ["页面1", "页面2", "页面3" ] as [Any]
        segmented = UISegmentedControl(items:items)
//        segmented.center = self.view.center
        segmented.frame = CGRect(x: 0, y: kNavigationBarHeight, width: kScreenW, height: 40)
        
        //默认选中第二项
        segmented.selectedSegmentIndex = 0
        
        //添加值改变监听
        segmented.addTarget(self, action: #selector(self.segmentDidchange(_:)),
                            for: .valueChanged)
        
        //修改选项颜色（包括图片选项）
        segmented.tintColor = UIColor.systemBlue
        
        //设置背景图像。
//        segmented.setBackgroundImage(UIImage(named: "backImage0"), for: UIControl.State.normal, barMetrics: UIBarMetrics.default)
        
        //根据其内容宽度调整段宽度
        segmented.apportionsSegmentWidthsByContent = true
        
        self.view.addSubview(segmented)
        
        //移动指定的子视图，使其显示在其同级元素的顶部。
//        view.bringSubviewToFront(UIView)
    }
     
    @objc func segmentDidchange(_ segmented:UISegmentedControl){
        //获得选项的索引
        print(segmented.selectedSegmentIndex)
        //获得选择的文字
        print(segmented.titleForSegment(at: segmented.selectedSegmentIndex) ?? "")
        
        collectionView.scrollToItem(at: IndexPath(item: segmented.selectedSegmentIndex, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
    }
    
    
    //MARK: - 网格
    var cellw = kScreenW //依据间距调整，当前是0间距
    var cellh = kScreenH - kNavigationBarHeight - 40
    var collectionView :UICollectionView!
    func createcollectionView(){
        //创建布局模式对象
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0//item左右间隔
        flowLayout.minimumLineSpacing = 0//item上下间隔
        //CollectionView上下左右边距
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //设置cell尺寸
        flowLayout.itemSize = CGSize(width: cellw, height: cellh)
        //设置滑动方向
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        //创建UICollectView对象
        collectionView = UICollectionView(frame: CGRect(x: 0, y: kNavigationBarHeight + 40, width: cellw, height: cellh), collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //创建重用cell（集合对象是代码生成的而不是NIB或故事板生成的因此需要注册一个UICollectionCell，否则初始化时会发生错误）
        collectionView.register(SubCell.self, forCellWithReuseIdentifier: "cell")
        
        
        view.addSubview(collectionView)
        
    }
}


extension MySegmentAndPageVC : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    //返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SubCell
        cell.backgroundColor = kRGB(Int(arc4random_uniform(256)),Int(arc4random_uniform(256)),Int(arc4random_uniform(256)))
        cell.content = "page\(indexPath.row)"
        return cell
    }
}

extension MySegmentAndPageVC : UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index:Int = Int(abs(scrollView.contentOffset.x)/cellw)
        
        print("index ======= \(index)")
        segmented.selectedSegmentIndex = index
        
    }
}

//MARK: - 子视图


class SubCell: UICollectionViewCell {
    var lable:UILabel!
    var content :String? {
        didSet{
            lable.text = content
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lable = UILabel()
        lable.textColor = UIColor.black
        lable.textAlignment = .center
        self.contentView.addSubview(lable)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        lable?.frame = self.bounds
    }
}


//子视图
class SubView: UIView {
    private var textLabel :UILabel!
    
    var content :String? {
        didSet{
            textLabel.text = content
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.orange
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 30))
        textLabel.center = self.center
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 33)
        textLabel.textColor = .white
        textLabel.text = "电影"
        self.addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
