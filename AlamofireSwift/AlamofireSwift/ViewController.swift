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
        Alamofire.request("https://capi.douyucdn.cn/api/v1/getbigDataRoom").responseString { (response) in
                        print(response)
                    }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

