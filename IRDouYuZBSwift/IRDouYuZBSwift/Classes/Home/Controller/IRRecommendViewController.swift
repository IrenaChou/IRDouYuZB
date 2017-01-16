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
private let kCycleViewHeight : CGFloat =  kScreenWidth * 3 / 8

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
    lazy var recommendCycleView : IRCycleView = {
        let cycleView = IRCycleView.cycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewHeight, width: kScreenWidth, height: kCycleViewHeight)
        return cycleView
    }()
    
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
        
        //将cycleView添加到collectionView中
        collectView.addSubview(recommendCycleView)
        
        //设置collectionView的内边距
        collectView.contentInset = UIEdgeInsets(top: kCycleViewHeight, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 请求数据
extension IRRecommendViewController {
    func loadData(){
        recommendVM.requestData { 
            self.collectView.reloadData()
        }
    }
}

// MARK: - 遵守UICollectionViewDataSource协议
extension IRRecommendViewController : UICollectionViewDataSource{
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出模型
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.row]
        
//        定义cell
        let cell : IRCollectionBaseCell!
        
        if indexPath.section == 1 {
            cell = collectView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! IRCollectionPrettyCell
        }else{
            cell = collectView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! IRCollectionNormalCell
        }
        cell.anchor = anchor
        return cell
    }

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出section的HeaderView
        let headerView = collectView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! IRCollectionHeaderView
    
        //设置数据
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
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



