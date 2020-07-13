//
//  VideoTableCell.swift
//  newTest
//
//  Created by one on 2020/7/13.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit


class VideoTableCell: UITableViewCell {
    
    weak var model :VideoModel? {
        didSet{
            
        }
    }
    private var imageV :UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print("\(self.classForCoder): \(#function)")
        
        createrUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(self.classForCoder): \(#function)")
    }
    
    
    
    let cover1 :String = "https://p1.pstatp.com/large/tos-cn-p-0015/86a5a7ee215e4b81b6751edbb02f7cc9_1588413349.jpg"
//    let cover2 :String = "https://p1.pstatp.com/large/tos-cn-p-0015/0a4c42c89fea4e2e90c072ea4b392e34_1590146886.jpg"
//    private lazy var coverImg :UIImageView = {
//        let v = UIImageView(frame: self.bounds)
//        v.contentMode = .scaleAspectFit
//        return v
//    }()
//    var cover :String?{
//        didSet{
//            coverImg.kf.setImage(with: URL(string: cover!))
//        }
//    }
    func createrUI(){
//        imageV = UIImageView(image: UIImage(named: "backImage0"))
        imageV = UIImageView()
        imageV.kf.setImage(with: URL(string: cover1))
        imageV.contentMode = .scaleAspectFit
        self.addSubview(imageV)
        
        imageV.frame.size = CGSize(width: kScreenW, height: kScreenH)
    }
}

