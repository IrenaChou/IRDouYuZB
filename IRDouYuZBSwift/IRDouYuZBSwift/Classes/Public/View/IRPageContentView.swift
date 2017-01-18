//
//  IRPageContentView.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/6.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

private let kContentCellIdentity = "kContentCellIdentity"

protocol IRPageContentViewDelegate : class{
    func pageContentView(pageContentView:IRPageContentView ,progress: CGFloat,sourceIndex: Int,targetIndex: Int)
}

class IRPageContentView: UIView {

    // MARK: -定义属性
     var childVCs : [UIViewController]
     weak var parentViewCtrl : UIViewController?
     var starContentOffSetX : CGFloat = 0
     weak var delegate : IRPageContentViewDelegate?
    var isForbidScrollDelegate : Bool = false
    
    
    // MARK: -懒加载属性
    lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collectView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectView.showsHorizontalScrollIndicator = false
        collectView.isPagingEnabled = true
        collectView.bounces = false
//        设置数据源
        collectView.dataSource = self
        collectView.delegate = self
        collectView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellIdentity)
                
        return collectView
    }()
    
    /// 自定义构造函数
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - childViewCtrls: 子控制器
    ///   - parentViewCtrl: 存放子控制器的容器
    init(frame: CGRect,childViewCtrls: [UIViewController],parentViewCtrl : UIViewController?) {
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
            parentViewCtrl?.addChildViewController(childVC)
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
extension IRPageContentView : UICollectionViewDelegate{
    /// 开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        //保存偏移量
        starContentOffSetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否是点击事件
        if isForbidScrollDelegate { return }
            
        //获取滚动的进度
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //判断滑动的方向
        let scrollViewWidth = scrollView.bounds.width
        let currentOffSetX = scrollView.contentOffset.x
//        print("currentOffSetX ==\(currentOffSetX) \n starContentOffSetX == \(starContentOffSetX)")
        if currentOffSetX > starContentOffSetX {
            //左滑
            progress = currentOffSetX / scrollViewWidth - floor(currentOffSetX / scrollViewWidth)
            
            sourceIndex = Int(currentOffSetX / scrollViewWidth)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            if currentOffSetX - starContentOffSetX == scrollViewWidth {
                progress = 1.0
                targetIndex = sourceIndex
            }

//            print("左 progress=\(progress),targetIndex=\(targetIndex),sourceIndex=\(sourceIndex)")

        }else{
            //右滑
            progress = 1 - (currentOffSetX / scrollViewWidth - floor(currentOffSetX / scrollViewWidth))
            
            targetIndex = Int(currentOffSetX / scrollViewWidth)
            
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
//            print("右\(progress)")

        }
        
        
//        print("右 progress=\(progress),targetIndex=\(targetIndex),sourceIndex=\(sourceIndex)")
        
        delegate?.pageContentView(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        

    }
    

}

// MARK: - 对外开放的方法
extension IRPageContentView {
    func setCurrentIndex(currentIndex: Int)  {
        //记录禁止执行代理方法
        isForbidScrollDelegate = true
        
        //滚动collectionCell
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
}
