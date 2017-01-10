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
        NetworkTools.requestData(type: .POST, URLString: "http://httpbin.org/post") { (result) in
            print(result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

