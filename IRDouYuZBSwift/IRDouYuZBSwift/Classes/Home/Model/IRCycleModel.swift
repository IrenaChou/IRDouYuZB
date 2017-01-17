//
//  IRCycleModel.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/17.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRCycleModel: NSObject {
    /// 标题
    var title : String = ""
    /// 展示图片地址
    var pic_url : String = ""
    
    /// 对应的主播信息
    var room : [String : NSObject]?{
        didSet{
            guard let room = room else { return }
            anchor = IRAnchorModel(dict: room)
        }
    }
    
    /// 主播信息对应的模型对象
    var anchor : IRAnchorModel?
    
    // MARK:- 自定义构造函数
    init(dict: [String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
}
