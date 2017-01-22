//
//  IRGameViewController.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/18.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

// MARK:- 常量定义
private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenWidth - kEdgeMargin * 2) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kGameCellID : String = "kGameCellID"
private let kHeaderViewID : String = "kHeaderViewID"
private let kCollectHeaderH : CGFloat = 50
private let kGameViewH : CGFloat = 90

class IRGameViewController: IRBaseViewController {
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //设置collectionView的布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
//        collectionView头部设置
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kCollectHeaderH)
        

        let colView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
         colView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
         colView.register(UINib(nibName: "IRCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        colView.dataSource = self
        
        colView.backgroundColor = UIColor.white
        
        //注册collectionView头部
        colView.register(UINib(nibName: "IRCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        colView.contentInset = UIEdgeInsets(top: kCollectHeaderH + kGameViewH, left: 0, bottom: 0, right: 0)

        return colView
    }()
    fileprivate lazy var gameViewModel : IRGameViewModel = IRGameViewModel()
    fileprivate lazy var topHeaderView : IRCollectionHeaderView = {
       let headerView = IRCollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kCollectHeaderH+kGameViewH), width: kScreenWidth, height: kCollectHeaderH)
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        
        headerView.titleLabel.text = "常见"
        headerView.moreBtn.isHidden = true
        return headerView
    }()
    fileprivate lazy var gameView : IRRecommendGameView = {
        let gameView = IRRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
        
        return gameView
    }()
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        
        
    }
}

// MARK: - 设置UI数据
extension IRGameViewController{
    override func setupUI(){
        
        contentView = collectionView
        
        view.addSubview(collectionView)
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        
        super.setupUI()
    }
}



// MARK: - 请求数据
extension IRGameViewController {
    fileprivate func loadData (){
        gameViewModel.loadAllGameData {
            self.collectionView.reloadData()
            
            //展示常用游戏【取前10条数据】
            self.gameView.groups = Array(self.gameViewModel.games[0..<10])
            
            //数据请求完成
            self.loadDataFinish()

        }
    }
}

// MARK: - 遵守uicollectionView数据源
extension IRGameViewController : UICollectionViewDataSource{
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! IRCollectionGameCell
        cell.baseGame = gameViewModel.games[indexPath.item]
        return cell
    }

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.games.count
    }

    //设置collection的headerView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! IRCollectionHeaderView
        
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}
