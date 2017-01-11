//
//  IRRecommendViewController.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/10.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

// MARK:- 定义常量
private let kItemMargin : CGFloat = 10
private let kItemWidth : CGFloat = (kScreenWidth - kItemMargin * 3)/2
private let kNormalItemHeight : CGFloat = kItemWidth * 3 / 4
private let kPrettyItemHeight : CGFloat = kItemWidth * 4 / 3
/// UICollectionView 组头
private let kHeaderViewHeight : CGFloat = 50
private let kNormalCellID : String = "kNormalCellID"
private let kPrettyCellID : String = "kPrettyCellID"
private let kHeaderViewID : String = "kHeaderViewID"

class IRRecommendViewController: UIViewController {
    // MARK:- 懒加载
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
        collectV.delegate = self
        collectV.backgroundColor = UIColor.white
        
        //让collectionView随着父控件拉伸
        collectV.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        collectV.register(UINib(nibName: "IRCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectV.register(UINib(nibName: "IRCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)

        //注册collectionView组头[Nib]
        collectV.register(UINib(nibName: "IRCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "kHeaderViewID")

        
        return collectV
    }()
    
    lazy var recommendVM : IRRecommendViewModel = IRRecommendViewModel()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // 设置UI界面
        setupUI()

        // 发送网络请求
        loadData()
    }
}

// MARK: - 设置UI界面的内容
extension IRRecommendViewController{
    func setupUI(){
        view.addSubview(collectView)
    }
}

// MARK: - 请求数据
extension IRRecommendViewController {
    func loadData(){
        recommendVM.requestData()
    }
}

// MARK: - 遵守UICollectionViewDataSource协议
extension IRRecommendViewController : UICollectionViewDataSource{
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : UICollectionViewCell!
        
        if indexPath.section == 1 {
            cell = collectView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        }else{
            cell = collectView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }

        return cell
    }

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出section的HeaderView
        let headerView = collectView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
    
        
        return headerView
    }
}

// MARK: - 遵守UICollectionViewDelegateFlowLayout协议
extension IRRecommendViewController : UICollectionViewDelegateFlowLayout {

    //设置Item尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemWidth, height: kPrettyItemHeight)
        }
        return CGSize(width: kItemWidth, height: kNormalItemHeight)
    }
}



