
//
//  IRRecommendViewModel.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/11.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit
import Alamofire

class IRRecommendViewModel {
    // MARK:- 懒加载属性
    lazy var anchorGroups : [IRAnchorGroup] = [IRAnchorGroup]()
    
}


// MARK: - 发送网络请求
extension IRRecommendViewModel {
    func requestData() {
        
        //1. 参数
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        
        //2.创建group
        let dispatchGroup = DispatchGroup()
        
        
        
        
//        DispatchGroup.enter(dispatchGroup)
        
        //请求推荐数据
        NetworkTools.requestData(type: MethodType.Get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",parameter: ["time":NSDate.getCurrentTime()]) { (result) in
            // 将result转成字典类型
            guard let resuletDict = result as? [String:NSObject] else {return}
            
            //根据data的key，获取数组数据
            guard let dataArray = resuletDict["data"] as? [[String:NSObject]] else { return }
            
            //遍历数组，获取字典，将字典转成模型对象
            //创建组
            let group = IRAnchorGroup()
            group.tag_name = "热门"
            group.icon_name = "home_header_hot"
            //获取主播数据
            for dict in dataArray {
                let anchor = IRAnchorModel(dict: dict)
                group.anchors.append(anchor)
            }
//            DispatchGroup.leave(dispatchGroup)
        }
        //请求颜值数据
        //颜值
        NetworkTools.requestData(type: MethodType.Get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",parameter: parameters) { (result) in
            print(result)
            
            // 将result转成字典类型
            guard let resuletDict = result as? [String:NSObject] else {return}
            
            //根据data的key，获取数组数据
            guard let dataArray = resuletDict["data"] as? [[String:NSObject]] else { return }
            
            //遍历数组，获取字典，将字典转成模型对象
            //创建组
            let group = IRAnchorGroup()
            group.tag_name = "颜值"
            group.icon_name = "home_header_phone"
            //获取主播数据
            for dict in dataArray {
                let anchor = IRAnchorModel(dict: dict)
                    group.anchors.append(anchor)
            }
        }
        print("随机数： \(NSDate.getCurrentTime())）")
        
        //请求其它部分的游戏数据
        NetworkTools.requestData(type: MethodType.Get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate",parameter: parameters) { (result) in
            
            // 将result转成字典类型
            guard let resuletDict = result as? [String:NSObject] else {return}
            
            //根据data的key，获取数组数据
            guard let dataArray = resuletDict["data"] as? [[String:NSObject]] else { return }
            
            //遍历数组，获取字典，将字典转成模型对象
            for dict in dataArray {
                let group = IRAnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            //test print
//            for group in self.anchorGroups{
//                for anchor in group.anchors{
//                    print(anchor.nickname)
//                }
//                print("---------")
//            }
            
        }
    }
}
