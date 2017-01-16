//
//  IRCollectionPrettyCell.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/10.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit
import Kingfisher

class IRCollectionPrettyCell: IRCollectionBaseCell {
    
    // MARK:- 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    
    // MARK:- 定义属性模型
    override var anchor : IRAnchorModel?{
        didSet{
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, for: UIControlState.normal)
        }
    }

}
