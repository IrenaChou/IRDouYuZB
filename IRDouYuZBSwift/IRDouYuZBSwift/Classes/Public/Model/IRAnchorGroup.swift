//
//  IRAnchorGroup.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/13.
//  Copyright © 2017年 ir. All rights reserved.

//  data下的单个组model

import UIKit

class IRAnchorGroup: IRBaseGameModel {
    
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]?{
        didSet {
            /// 字典转模型
            guard let room_list = room_list else { return }
            for dict in room_list{
                anchors.append(IRAnchorModel(dict: dict))
            }
        }
    }
    /// 组显示的标题
//    var tag_name : String?
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors : [IRAnchorModel] = [IRAnchorModel]()
    
    var tag_id : Int?
//    
//    /// 游戏对应的图标
//    var icon_url : String = ""

}
