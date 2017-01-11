//
//  NSDate_Extension.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/11.
//  Copyright © 2017年 ir. All rights reserved.
//

import Foundation

extension NSDate {
// MARK:- 获取当前时间的秒数
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
