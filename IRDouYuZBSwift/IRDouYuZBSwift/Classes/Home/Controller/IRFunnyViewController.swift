//
//  IRFunnyViewController.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/22.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class IRFunnyViewController: IRBaseAnchorViewController {
    fileprivate lazy var funnyVm : IRFunnyViewModel = IRFunnyViewModel()
}

// MARK: - 布局UI
extension IRFunnyViewController{
    override func setupUI() { 
        super.setupUI()
        
        let layout = collectView.collectionViewLayout as! UICollectionViewFlowLayout
        //去除组
        layout.headerReferenceSize = CGSize.zero
        collectView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
        
    }
    

}

// MARK: - 请求数据
extension IRFunnyViewController{
    override func loadData(){
        baseViewModel = funnyVm
        
        
        funnyVm.funnyLoadData { 
            self.collectView.reloadData()
            //数据请求完成
            self.loadDataFinish() 
        }
    }
}
