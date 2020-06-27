//
//  CustomCVCell.swift
//  newTest
//
//  Created by one on 2020/6/26.
//  Copyright © 2020 one. All rights reserved.
//

import UIKit

class CustomCVCell: UICollectionViewCell {
    var lable:UILabel? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lable = UILabel()
        lable?.textColor = UIColor.black
        lable?.textAlignment = .center
        self.contentView.addSubview(lable!)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        lable?.frame = self.bounds
    }
}
