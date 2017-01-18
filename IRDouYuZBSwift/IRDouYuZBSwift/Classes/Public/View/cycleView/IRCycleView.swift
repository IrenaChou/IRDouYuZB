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
    var cycleTimer : Timer?
    
    var cycleModels : [IRCycleModel]?{
        didSet{
            collectionView.reloadData()
            pageCtrl.numberOfPages = cycleModels?.count ?? 0
            
            //默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            
            collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.left, animated: false)
            
            //添加定时器
            removeCycleTimer()
            addCycleTimer()
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
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        return cell
    }

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000  //为实现可以循环滚动
    }

    
}


// MARK: - 遵守UICollectionViewDelegate协议
extension IRCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //滚到一半就显示下一页
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        let currentPage = Int(offsetX / scrollView.bounds.width)
        pageCtrl.currentPage = currentPage % (cycleModels?.count ?? 1)
    }
    
    
    /// 手动拖拽停止控制器【开始拖拽】
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            removeCycleTimer()
    }
    /// 【结束拖拽】
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}


// MARK: - 对定时器的操作方法
extension IRCycleView {
    func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    func removeCycleTimer(){
        //从运行循环中移除定时器
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    /// 定时器滚动调用的方法
    func scrollToNext(){
        //滚到一半就显示下一页
        let contentOffsetX = collectionView.contentOffset.x
        let offsetX = contentOffsetX + collectionView.bounds.width
        //滚动collectionView
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
}
