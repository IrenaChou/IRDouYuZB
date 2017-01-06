//
//  IRHomeViewController.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/5.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

private let kTtitleViewHeight : CGFloat = 40


class IRHomeViewController: UIViewController {
    
    
    // MARK: - 懒加载属性
    private lazy var pageTitleView : IRPageTitleView = {
        let titleFrame = CGRect.init(x: 0, y: kStatusBarHeight+kNavigationBarHeight, width: kScreenWidth, height: kTtitleViewHeight)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = IRPageTitleView(frame: titleFrame, titles: titles)
        
        return titleView
        
    }()
    

    private lazy var pageContentView : IRPageContentView = {
        let contentY = kStatusBarHeight + kNavigationBarHeight + kTtitleViewHeight
        let contentFrame = CGRect(x: 0, y: contentY, width: kScreenWidth, height: kScreenHeight - contentY)
        
       var childVCs = [ UIViewController() ]
        for _ in 0..<4{
           let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        
       let contentV = IRPageContentView(frame: contentFrame, childViewCtrls: childVCs, parentViewCtrl: self)
        
        return contentV
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
// MARK: - - 设置UI界面 extension IRHomeViewController
        setupUI()
        
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }

}

// MARK: - 设置UI界面
extension IRHomeViewController{
    func setupUI(){
//        无需调整scrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
    }
    
    /// 设置NavigationBar
    private func setupNavigationBar(){
        
        /// 设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        
        /// 设置右侧Item
        let size = CGSize(width: 40, height: 40)
        let rightHistoryBtn = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let searchHistoryBtn = UIBarButtonItem(imageName: "searchIconDark", highImageName: "searchBtnIconHL", size: size)
        
        let scanHistoryBtn = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [rightHistoryBtn , searchHistoryBtn,scanHistoryBtn ]
        
    }
}
