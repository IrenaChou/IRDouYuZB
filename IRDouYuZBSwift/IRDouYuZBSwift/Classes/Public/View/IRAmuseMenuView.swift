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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellId, for: indexPath)
        cell.backgroundColor = UIColor.purple
        return cell
    }

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    
}
