//
//  IRRecommendViewController.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/10.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

// MARK:- 定义常量
private let kPrettyItemHeight : CGFloat = kItemWidth * 4 / 3
private let kPrettyCellID : String = "kPrettyCellID"
private let kCycleViewHeight : CGFloat = kScreenWidth * 3 / 8
private let krecommendGameViewHeight : CGFloat = 90

class IRRecommendViewController: IRBaseAnchorViewController {
    // MARK:- 懒加载
    fileprivate lazy var recommendVM : IRRecommendViewModel = IRRecommendViewModel()
    fileprivate lazy var recommendCycleView : IRCycleView = {
        let cycleView = IRCycleView.cycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewHeight+krecommendGameViewHeight), width: kScreenWidth, height: kCycleViewHeight)
        return cycleView
    }()
    fileprivate lazy var recommendGameView : IRRecommendGameView = {
        let gameView = IRRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -krecommendGameViewHeight, width: kScreenWidth, height: krecommendGameViewHeight)
        return gameView
    }()
}

// MARK: - 设置UI界面的内容
extension IRRecommendViewController{
    override func setupUI(){
        super.setupUI()

        //将cycleView添加到collectionView中
        collectView.addSubview(recommendCycleView)
        //将recommendGameView添加到collectionView中
        collectView.addSubview(recommendGameView)
        //设置collectionView的内边距
        collectView.contentInset = UIEdgeInsets(top: kCycleViewHeight+krecommendGameViewHeight, left: 0, bottom: 0, right: 0)

        collectView.register(UINib(nibName: "IRCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
    }
}

// MARK: - 请求数据
extension IRRecommendViewController {
    override func loadData(){
        baseViewModel = recommendVM
        
        recommendVM.requestData {[weak self] in
            self?.collectView.reloadData()
            
            //将推荐数据传递给gameView
            var groups = self?.recommendVM.anchorGroups
            groups!.removeFirst()
            groups!.removeFirst()
            
            
            //添加更多组
            let moreGroup = IRAnchorGroup()
            moreGroup.tag_name = "更多"
            groups!.append(moreGroup)

            self?.recommendGameView.groups = groups
            
            //数据请求完成
            self?.loadDataFinish()
        }
//        请求图片轮播数据
        recommendVM.requestCycleData {
            self.recommendCycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

extension IRRecommendViewController : UICollectionViewDelegateFlowLayout{

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! IRCollectionPrettyCell
            
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
        }else{
            return super.collectionView(collectionView,cellForItemAt: indexPath)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.section  == 1){
            return CGSize(width: kItemWidth, height: kPrettyItemHeight)
        }else{
            return CGSize(width: kItemWidth, height: kNormalItemHeight)
        }
    }
}


