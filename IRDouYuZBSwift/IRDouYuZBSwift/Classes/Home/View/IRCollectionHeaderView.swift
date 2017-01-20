//
//  IRCollectionHeaderView.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/10.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRCollectionHeaderView: UICollectionReusableView {

    // MARK:- 控件的属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    // MARK:- 定义模型属性
    var group : IRAnchorGroup?{
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}


// MARK: - 从xib中快速创建的类方法
extension IRCollectionHeaderView{
    class func collectionHeaderView() -> IRCollectionHeaderView{
        return Bundle.main.loadNibNamed("IRCollectionHeaderView", owner: nil, options: nil)?.first as! IRCollectionHeaderView
    }
}
