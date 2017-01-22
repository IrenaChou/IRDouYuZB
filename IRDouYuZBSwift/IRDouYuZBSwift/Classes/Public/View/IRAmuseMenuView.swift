//
//  IRAmuseMenuView.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/20.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

// MARK:- 常量
private let kMenuCellId : String = "kMenuCellId"

class IRAmuseMenuView: UIView {
    
    var groups : [IRAnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    
    // MARK:- 从XIB中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "IRAmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellId)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }
}

// MARK: - 通过xib创建本类方法
extension IRAmuseMenuView{
    class func amuseMenuView() -> IRAmuseMenuView {
        return Bundle.main.loadNibNamed("IRAmuseMenuView", owner: nil, options: nil)?.first as! IRAmuseMenuView
    }
}


// MARK: - 遵守UICollectionView数据源
extension IRAmuseMenuView : UICollectionViewDataSource{
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellId, for: indexPath) as! IRAmuseMenuViewCell
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil { return 0 }
        
        let pageNum = (groups!.count - 1) / 8 + 1
        pageCtrl.numberOfPages = pageNum
        
        return pageNum
    }

    
    /// 为cell赋值
    private func setupCellDataWithCell(cell: IRAmuseMenuViewCell,indexPath: IndexPath){
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        //处理越界问题
        if endIndex > groups!.count - 1{
            endIndex = groups!.count - 1
        }
        
        cell.groups = Array(groups![startIndex...endIndex])
    }
}

// MARK: - 遵守UICollectionView代理协议
extension IRAmuseMenuView : UICollectionViewDelegate{
    
    /// 监听collectionView滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageCtrl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
}
