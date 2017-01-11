
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

}


// MARK: - 发送网络请求
extension IRRecommendViewModel {
    func requestData() {
        //请求推荐数据
//         "http://capi.douyucdn.cn/api/v1/getbigDataRoom"
        //请求颜值数据
        //颜值
//        let prettyURL = "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
        
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1484115800
        
        print(NSDate.getCurrentTime())
        
        //请求其它部分的游戏数据
//        ,parameter: ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        NetworkTools.requestData(type: MethodType.Get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate") { (result) in
            print(result)
        }

    }
}
