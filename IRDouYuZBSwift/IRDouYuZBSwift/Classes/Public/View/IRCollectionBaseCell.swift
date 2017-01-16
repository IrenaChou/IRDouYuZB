//
//  IRCollectionBaseCell.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/16.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRCollectionBaseCell: UICollectionViewCell {
    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    // MARK:- 定义属性模型
    var anchor : IRAnchorModel?{
        didSet{
            guard let anchor = anchor else { return }
            
            nickNameLabel.text = anchor.nickname
            
            //            在线人数的显示
            var onlineStr : String?
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: UIControlState.normal)
            
            
            //            显示封面图片【网络加载】
            guard let url = URL(string: anchor.vertical_src) else {
                return
            }
            iconImageView.kf.setImage(with: url)
        }

    }
}
