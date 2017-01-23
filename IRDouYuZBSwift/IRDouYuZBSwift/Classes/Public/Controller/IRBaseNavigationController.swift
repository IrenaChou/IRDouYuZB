//
//  IRBaseNavigationController.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/5.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取系统的pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        guard let gesView = systemGes.view else { return }
        
        //获取target/action【通过运行时】
        //此处的key需特别注意
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        guard let target = targetObjc.value(forKey: "target") else { return }
        let action = Selector(("handleNavigationTransition:"))
 
        //创建自己的pan手势
        let panGes = UIPanGestureRecognizer(target: target, action: action)
        gesView.addGestureRecognizer(panGes)
        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count >= 1{
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
}
