//
//  IRCollectionCycleCell.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/17.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit
import Kingfisher

class IRCollectionCycleCell: UICollectionViewCell {
    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK:- 定义模型属性
    var cycleModel : IRCycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            
            let url = URL(string: cycleModel?.pic_url ?? "" )!
            iconImageView.kf.setImage(with: url, placeholder: Image.init(named: "Img_default"))
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
