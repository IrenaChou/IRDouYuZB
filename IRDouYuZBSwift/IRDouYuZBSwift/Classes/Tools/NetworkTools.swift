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
    class func requestData(type : MethodType,URLString : String,parameter:[String:String]? = nil,finishedCallback:@escaping (_ result  : Any)->()){
        
        let method = type == .Get ? HTTPMethod.get :  HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameter).responseJSON { (response) in
            guard let result = response.result.value else {
                //错误
                print("错误: \(response.result.error)")
                return
            }
            
            finishedCallback(result)
            
        }
    }
}
