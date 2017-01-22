//
//  IRAmuseViewController.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/19.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

// MARK:- 常量
private let kMeunViewHeight : CGFloat = 200

class IRAmuseViewController: IRBaseAnchorViewController {
  
    lazy var amuseVm : IRAmuseViewModel = IRAmuseViewModel()
    
    lazy var amuseMenuView : IRAmuseMenuView = {
       let amuseMenu = IRAmuseMenuView.amuseMenuView()
        amuseMenu.frame = CGRect(x: 0, y: -kMeunViewHeight, width: kScreenWidth, height: kMeunViewHeight)
        
        return amuseMenu
    }()
}

// MARK: - 设置UI界面
extension IRAmuseViewController{
    override func setupUI() {
        super.setupUI()
        
        collectView.addSubview(amuseMenuView)

        collectView.contentInset = UIEdgeInsets(top: kMeunViewHeight, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 请求数据
extension IRAmuseViewController{
    override func loadData(){
    
        baseViewModel = amuseVm
        
        amuseVm.loadAmuseData {
            self.collectView.reloadData()
            
            self.amuseMenuView.groups = self.amuseVm.anchorGroups
            
            self.amuseMenuView.groups?.removeFirst()
            
            //数据请求完成
            self.loadDataFinish()

        }
    }

}





