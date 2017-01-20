//
//  IRBaseGameModel.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/19.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRBaseGameModel: NSObject {
    
    var tag_name : String = ""
    var icon_url : String = ""
    
    
    /// 重写构造函数
    override init() {
        super.init()
    }
    
    init(dict : [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
}
