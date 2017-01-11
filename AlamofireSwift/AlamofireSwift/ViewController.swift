//
//  ViewController.swift
//  AlamofireSwift
//
//  Created by zhongdai on 2017/1/10.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        NetworkTools.requestData(type: .Get, URLString: "http://httpbin.org/get") { (result) in
//            print(result)
//        }
        NetworkTools.requestData(type: MethodType.Get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate",parameter: ["limit":"4","offset":"0","time":"1484124821"]) { (result) in
                print(result)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

