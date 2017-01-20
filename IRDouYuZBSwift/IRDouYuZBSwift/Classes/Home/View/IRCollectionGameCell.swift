//
//  IRCollectionGameCell.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/18.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit
import Kingfisher

class IRCollectionGameCell: UICollectionViewCell {
    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK:- 定义属性
    var baseGame : IRBaseGameModel? {
        didSet{
            guard let url = URL(string: (baseGame?.icon_url)!) else {
                return
            }
            iconImageView.kf.setImage(with: url, placeholder: Image.init(named: "btn_v_more"))
            
            titleLabel.text = baseGame?.tag_name ?? ""
        }
    }
    
    // MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
