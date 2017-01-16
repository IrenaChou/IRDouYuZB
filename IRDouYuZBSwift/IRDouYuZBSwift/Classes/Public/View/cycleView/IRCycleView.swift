//
//  IRCycleView.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/16.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRCycleView: UIView {
    override func awakeFromNib() {
//        设置该控件不随着父控制的拉伸而拉伸
//        autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
    }
}

// MARK: - 提供一个快速创建本view的类方法
extension IRCycleView {
    class func cycleView() -> IRCycleView {
        return Bundle.main.loadNibNamed("IRCycleView", owner: nil, options: nil)?.first as! IRCycleView
    }
}
