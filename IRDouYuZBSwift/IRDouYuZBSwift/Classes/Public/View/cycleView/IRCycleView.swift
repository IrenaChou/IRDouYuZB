//
//  IRCycleView.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/16.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit
// MARK:- 常量
private let kCycleCellId : String = "kCycleCellId"

class IRCycleView: UIView {
    // MARK:- 定义属性
    var cycleModels : [IRCycleModel]?{
        didSet{
            collectionView.reloadData()
            pageCtrl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    
    // MARK:- 系统回调
    override func awakeFromNib() {
        //设置该控件不随着父控制的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        
        //注册cell【通过xib】
        collectionView.register(UINib(nibName: "IRCollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellId)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置collectionView的布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

// MARK: - 提供一个快速创建本view的类方法
extension IRCycleView {
    class func cycleView() -> IRCycleView {
        return Bundle.main.loadNibNamed("IRCycleView", owner: nil, options: nil)?.first as! IRCycleView
    }
}


// MARK: - 遵守UICollectionViewDataSource协议
extension IRCycleView : UICollectionViewDataSource{
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as! IRCollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item]
        
        return cell
    }

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }

    
}


// MARK: - 遵守UICollectionViewDelegate协议
extension IRCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //滚到一半就显示下一页
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        let currentPage = Int(offsetX / scrollView.bounds.width)
        pageCtrl.currentPage = currentPage
    }
}
