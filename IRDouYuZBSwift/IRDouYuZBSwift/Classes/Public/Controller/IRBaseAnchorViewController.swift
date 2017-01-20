//
//  IRBaseAnchorViewController.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/20.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit
// MARK:- 定义常量
private let kItemMargin : CGFloat = 10
let kItemWidth : CGFloat = (kScreenWidth - kItemMargin * 3)/2
let kNormalItemHeight : CGFloat = kItemWidth * 3 / 4

/// UICollectionView 组头
private let kHeaderViewHeight : CGFloat = 50
private let kNormalCellID : String = "kNormalCellID"
private let kHeaderViewID : String = "kHeaderViewID"

class IRBaseAnchorViewController: UIViewController {

    // MARK:- 定义属性
    var baseViewModel : IRBaseViewModel!
    
    // MARK:- 懒加载属性
    lazy var collectView:UICollectionView = {[unowned self] in
        //创建部局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kNormalItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        
        //设置组的内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewHeight)
        
        //创建UICollectionView
        let collectV = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectV.dataSource = self
        collectV.backgroundColor = UIColor.white
        
        //让collectionView随着父控件拉伸
        collectV.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        collectV.register(UINib(nibName: "IRCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        //注册collectionView组头[Nib]
        collectV.register(UINib(nibName: "IRCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "kHeaderViewID")
        
        //设置collectionView的内边距
        collectV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return collectV
        }()
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}
// MARK: - 请求数据
extension IRBaseAnchorViewController{
    func loadData(){ }
}

// MARK: - 设置UI界面的内容
extension IRBaseAnchorViewController{
    func setupUI(){
        view.addSubview(collectView)
    }
}
// MARK: - 遵守UICollectionViewDataSource协议
extension IRBaseAnchorViewController : UICollectionViewDataSource{
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //  定义cell
        let cell : IRCollectionBaseCell!
        
        cell = collectView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! IRCollectionNormalCell
        
        cell.anchor = baseViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseViewModel.anchorGroups[section].anchors.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseViewModel.anchorGroups.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出section的HeaderView
        let headerView = collectView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! IRCollectionHeaderView
        
        headerView.group = baseViewModel.anchorGroups[indexPath.section]
        
        return headerView
    }
}
