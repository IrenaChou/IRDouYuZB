//
//  IRPageContentView.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/6.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

private let kContentCellIdentity = "kContentCellIdentity"


class IRPageContentView: UIView {

    // MARK: -定义属性
     var childVCs : [UIViewController]
     var parentViewCtrl : UIViewController
    
    
    // MARK: -懒加载属性
    lazy var collectionView : UICollectionView = {
       let  layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collectView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectView.showsHorizontalScrollIndicator = false
        collectView.isPagingEnabled = true
        collectView.bounces = false
//        设置数据源
        collectView.dataSource = self
        collectView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellIdentity)
        
//        设置代理
        collectView.delegate = self
        
        return collectView
    }()
    
    /// 自定义构造函数
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - childViewCtrls: 子控制器
    ///   - parentViewCtrl: 存放子控制器的容器
    init(frame: CGRect,childViewCtrls: [UIViewController],parentViewCtrl : UIViewController) {
        self.childVCs = childViewCtrls
        self.parentViewCtrl = parentViewCtrl
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置UI界面
extension IRPageContentView{
    func setupUI() {
        // 将所有子控制器添加到父控制器中
        for childVC in childVCs {
            parentViewCtrl.addChildViewController(childVC)
        }
        
        //添加collectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK: - 遵守<UICollectionViewDataSource>协议
extension IRPageContentView : UICollectionViewDataSource{
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellIdentity, for: indexPath)
        
        // 设置内容[cell循环利用，移除]
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)

        return cell
    }

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }

}

// MARK: - 遵守UICollectionViewDelegate协议
extension IRPageContentView : UICollectionViewDelegate {
    
}
