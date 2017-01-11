//
//  NetworkTools.swift
//  AlamofireSwift
//
//  Created by zhongdai on 2017/1/10.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit
import Alamofire

// MARK:- 定义请求协议类型
enum MethodType {
    case Get
    case POST
}
class NetworkTools {
    
    /// 网络请求
    ///
    /// - Parameters:
    ///   - type: 请求协议类型【Post,get】
    ///   - URLString: 请求地址【url】
    ///   - parameter: 请求参数【可不传】
    ///   - finishedCallback: 回调
    class func requestData(type : MethodType,URLString : String,parameter:[String:String]? = nil,finishedCallback:@escaping (_ result  : AnyObject)->()){
        
        let method = type == .Get ? HTTPMethod.get :  HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameter,headers: ["Content-Type":"application/json"]).responseJSON { (response) in
            guard let result = response.result.value else {
                //错误
                print(response.result.error ?? "")
                print("错误")
                return
            }
            finishedCallback(result as AnyObject)
       }
//        //设置manager属性 (重要)
//        var manger:SessionManager? = nil
//        
//        //配置 , 通常默认即可
//        let config:URLSessionConfiguration = URLSessionConfiguration.default
//        
//        //设置超时时间为15S
//        config.timeoutIntervalForRequest = 15
//        //根据config创建manager
//        manger = SessionManager(configuration: config)
//        //这里和上述大致相同
//        manger!.request("http://capi.douyucdn.cn/api/v1/getHotCate", method: .get, parameters: ["limit":"4","offset":"0","time":"1484124821"],encoding:JSONEncoding.default).response { (response) in
//            
//            print("-----------------\(response)")
//        }
    }
}
