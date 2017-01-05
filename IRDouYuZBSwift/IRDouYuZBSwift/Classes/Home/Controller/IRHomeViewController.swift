//
//  IRHomeViewController.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/5.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRHomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

// MARK: - 设置UI界面
extension IRHomeViewController{
    func setupUI(){
        setupNavigationBar()
    }
    
    /// 设置NavigationBar
    private func setupNavigationBar(){
        
        /// 设置左侧item
//        let leftBtn = UIButton()
//        leftBtn.setImage(#imageLiteral(resourceName: "logo"), for: UIControlState.normal)
//        leftBtn.sizeToFit()
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        
        /// 设置右侧Item
        let size = CGSize(width: 40, height: 40)
        let rightHistoryBtn = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let searchHistoryBtn = UIBarButtonItem(imageName: "searchIconDark", highImageName: "searchBtnIconHL", size: size)
        
        let scanHistoryBtn = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [rightHistoryBtn , searchHistoryBtn,scanHistoryBtn ]
        
    }
}
