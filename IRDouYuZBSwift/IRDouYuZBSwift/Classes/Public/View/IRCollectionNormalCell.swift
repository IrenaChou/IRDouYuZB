//
//  IRCollectionNormalCell.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/10.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRCollectionNormalCell: IRCollectionBaseCell {
    // MARK:- 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!

    
    // MARK:- 定义属性模型
    override var anchor : IRAnchorModel?{
        didSet{
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
          }
    }
}
