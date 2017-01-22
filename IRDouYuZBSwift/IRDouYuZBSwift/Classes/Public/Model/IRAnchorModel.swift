//
//  IRAnchorModel.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/13.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRAnchorModel: NSObject {
    var specific_catalog : String?
    
    /// 房间图片url
    var vertical_src : String = ""
    /// 判断直播设备【0=电脑直播，1=手机直播】
    var isVertical : Int = 0
    /// 主播昵称
    var nickname : String = ""
    /// 房间名
    var room_name : String = ""
    /// 房间id
    var room_id : Int = 0
    
    /// 在线观看人数
    var online : Int = 0
    
    /// 颜值所在城市
    var anchor_city : String = ""
    
//    var ranktype : String?
//    var subject : String?
//    var room_src : String?
//    var cate_id : String?
//    var specific_status : String?
//    var game_name : String?
//    var avatar_small : String?
//    var avatar_mid : String?
//    var vod_quality : String?
//    var child_id : String?
//    var show_time : String?
//    var show_status : String?
//    var jumpUrl : String?
    init(dict : [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
