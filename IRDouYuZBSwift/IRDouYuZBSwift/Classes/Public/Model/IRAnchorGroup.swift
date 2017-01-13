//
//  IRAnchorGroup.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/13.
//  Copyright © 2017年 ir. All rights reserved.

//  data下的单个组model

import UIKit

class IRAnchorGroup: NSObject {
    
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
    var tag_name : String?
    /// 组显示的图标
    var icon_name : String = "home_header_normal"

    /// 定义主播的模型对象数组
    lazy var anchors : [IRAnchorModel] = [IRAnchorModel]()
    
//    var push_vertical_screen : String?
//    var icon_url : String?
//    var push_nearby : String?
//    var tag_id : String?
    
    
    /// 重写构造函数 
    override init() {
        super.init()
    }
    
    init(dict : [String:NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    /// 重写此方法，防止model中的key与json中的key不匹配报错
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
//    /// 字典转模型
//    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "room_list" {
//            if let dataArray = value as? [[String:NSObject]] {
//                for dict in dataArray{
//                    anchors.append(IRAnchorModel(dict: dict))
//                }
//            }
//        }
//    }
}
