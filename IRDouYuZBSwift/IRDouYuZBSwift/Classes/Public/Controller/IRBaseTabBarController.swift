//
//  IRBaseTabBarController.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/5.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRBaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        childViewControllersSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UITabBar.appearance().tintColor = UIColor.orange
    }
    
    /// 为tabBarController添加子控制器
   private func childViewControllersSetup(){
        
        let homeNavCtrl = addChildViewController(barImageName: "btn_home", barTitleName: "主页",sbName: "Home")
        let columnNavCtrl = addChildViewController(barImageName: "btn_column", barTitleName: "直播",sbName: "Live")
        let liveNavCtrl = addChildViewController(barImageName: "btn_live", barTitleName: "关注",sbName:"Follow")
        let userNavCtrl = addChildViewController(barImageName: "btn_user", barTitleName: "我的",sbName:"Profile")
        
        let controlles = [ homeNavCtrl,columnNavCtrl,liveNavCtrl,userNavCtrl ]
        
        viewControllers = controlles
    }
    
    /// 创建子控制器
    ///
    /// - Parameters:
    ///   - barImageName: 控制器tabBarItem显示图片
    ///   - barTitleName: 控制器tabBarItem显示文本
    /// - Returns: 创建好的子控制器
   private func addChildViewController(barImageName:String,barTitleName:String,sbName:String ) -> IRBaseNavigationController {

        let sb = UIStoryboard(name: sbName, bundle: nil)
        
    
        let rootCtrl = sb.instantiateInitialViewController()!
        let navCtrl = IRBaseNavigationController(rootViewController: rootCtrl)
    
    
    
        navCtrl.tabBarItem.image = UIImage.init(named: barImageName+"_normal")
        navCtrl.tabBarItem.selectedImage = UIImage.init(named: barImageName+"_selected")
        navCtrl.tabBarItem.title = barTitleName
        
        
       return navCtrl
    }


}
