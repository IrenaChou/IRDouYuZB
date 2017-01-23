//
//  IRRoomNormalViewController.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/23.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRRoomNormalViewController: UIViewController,UIGestureRecognizerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
//        //保持返回手势不失效
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //显示导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension IRRoomNormalViewController{
    
}
