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
    class func requestData(type : MethodType,URLString : String,parameter:[String:String]? = nil,finishedCallback:@escaping (_ result  : AnyObject)->()){
        
        let method = type == .Get ? HTTPMethod.get :  HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
            guard let result = response.result.value else {
                //错误
                print(response.result.error ?? "")
                return
            }
            
            finishedCallback(result as AnyObject)
            
        }
    }
}
