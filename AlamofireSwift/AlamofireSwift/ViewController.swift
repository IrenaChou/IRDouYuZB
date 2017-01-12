//
//  ViewController.swift
//  AlamofireSwift
//
//  Created by zhongdai on 2017/1/10.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = "http://capi.douyucdn.cn/api/v1/getHotCate"

        //        //请求头
        let header: HTTPHeaders = [
//            "connection":"keep-alive",
            "Charsert":"utf-8",
            "Content-Type":"application/json",
            "Accept-Encoding":"gzip, identity"
        ]
//        let body:Data? = Data(base64Encoded: "test")
//        
//       let result = Alamofire.upload(body!, to: url, method: HTTPMethod.get, headers: header)
        
//        Alamofire.request(url, method: HTTPMethod.get, headers: header).response { (response) in
//            print(response)
//        }
        let reqMe = Alamofire.request(url, method: HTTPMethod.get, headers: header)
        
        
        reqMe.response { (response) in
            print(response)
        }

        //        print("\(result)")
//        Alamofire.upload( to: url, method: HTTPMethod.get, headers: header)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

