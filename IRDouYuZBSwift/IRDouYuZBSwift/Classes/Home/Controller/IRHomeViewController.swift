
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
    lazy var pageTitleView : IRPageTitleView = { [weak self] in
        let titleFrame = CGRect.init(x: 0, y: kStatusBarHeight+kNavigationBarHeight, width: kScreenWidth, height: kTtitleViewHeight)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = IRPageTitleView(frame: titleFrame, titles: titles)
        
        titleView.delegate = self
        
        
        return titleView
        
    }()
    

    lazy var pageContentView : IRPageContentView = {[weak self] in
        let contentH = kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kTtitleViewHeight - kTabbarHeight
        let contentFrame = CGRect(x: 0, y: kStatusBarHeight + kNavigationBarHeight + kTtitleViewHeight, width: kScreenWidth, height: contentH)
        
       var childVCs = [ UIViewController ]()
       childVCs.append(IRRecommendViewController());
        
        for _ in 0..<3{
           let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        
       let contentV = IRPageContentView(frame: contentFrame, childViewCtrls: childVCs, parentViewCtrl: self)
        
        contentV.delegate = self
        
        return contentV
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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


// MARK: - 遵守IRPageTitleViewDelegate协议
extension IRHomeViewController: IRPageTitleViewDelegate{
    func pageTitleViewDelegate(titleView: IRPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}


// MARK: - 遵守IRPageContentViewDelegate协议
extension IRHomeViewController : IRPageContentViewDelegate{
    func pageContentView(pageContentView: IRPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWith(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
