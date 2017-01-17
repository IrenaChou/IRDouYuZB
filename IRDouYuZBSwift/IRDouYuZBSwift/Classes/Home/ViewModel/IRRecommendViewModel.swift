
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
    lazy var bigDataGroup : IRAnchorGroup = IRAnchorGroup()
    lazy var prettyGroup : IRAnchorGroup = IRAnchorGroup()
    lazy var cycleModels : [IRCycleModel] = [IRCycleModel]()
}


// MARK: - 发送网络请求
extension IRRecommendViewModel {
    
    /// 请求推荐数据
    ///
    /// - Parameter finishCallBack: 请求数据后的回调
    func requestData(finishCallBack : @escaping () -> ()) {
        
        //1. 参数
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        
        //2.创建group
        let dispatchGroup = DispatchGroup()
        
//        进入组
        dispatchGroup.enter()
        
        //请求推荐数据
        NetworkTools.requestData(type: MethodType.Get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",parameter: ["time":NSDate.getCurrentTime()]) { (result) in
            // 将result转成字典类型
            guard let resuletDict = result as? [String:NSObject] else {return}
            
            //根据data的key，获取数组数据
            guard let dataArray = resuletDict["data"] as? [[String:NSObject]] else { return }
            
            //遍历数组，获取字典，将字典转成模型对象
//            let group = IRAnchorGroup()
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //获取主播数据
            for dict in dataArray {
                let anchor = IRAnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
//            离开组
            dispatchGroup.leave()
//            print("请求到0组")
            
        }
        //请求颜值数据
        //颜值
        dispatchGroup.enter()
        NetworkTools.requestData(type: MethodType.Get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",parameter: parameters) { (result) in
            // 将result转成字典类型
            guard let resuletDict = result as? [String:NSObject] else {return}
            
            //根据data的key，获取数组数据
            guard let dataArray = resuletDict["data"] as? [[String:NSObject]] else { return }
            
            //遍历数组，获取字典，将字典转成模型对象
            //创建组
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //获取主播数据
            for dict in dataArray {
                let anchor = IRAnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
//            离开组
            dispatchGroup.leave()
        }
        
        //请求其它部分的游戏数据
//        进入组
        dispatchGroup.enter()
        NetworkTools.requestData(type: MethodType.Get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate",parameter: parameters) { (result) in
            
            // 将result转成字典类型
            guard let resuletDict = result as? [String:NSObject] else {return}
            
            //根据data的key，获取数组数据
            guard let dataArray = resuletDict["data"] as? [[String:NSObject]] else { return }
            
            //遍历数组，获取字典，将字典转成模型对象
            for dict in dataArray {
                let group = IRAnchorGroup(dict: dict)
                
                if(group.tag_name == "颜值"){
                    continue
                }
                self.anchorGroups.append(group)
            }
//            离开组
            dispatchGroup.leave()
        }
        
//        判断是否所有数据都被请求到【做所有数据都请求到，同时更新ui】
        dispatchGroup.notify(queue: DispatchQueue.main) {
//            print("所有数据都请求到")
            
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallBack()
        }
    }


    
    /// 请求图片轮播数据
    ///
    /// - Parameter finishCallBack:  请求数据后的回调
    func requestCycleData(finishCallBack: @escaping () -> ()) {
        //请求推荐数据
        NetworkTools.requestData(type: MethodType.Get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameter: ["version":"2.300"]) { (result) in
            guard let resultDict = result as? [ String : NSObject ] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else{ return }
            
            for dict in dataArray {
              self.cycleModels.append(IRCycleModel(dict: dict))
            }
 
            finishCallBack()
        }
    }
}
