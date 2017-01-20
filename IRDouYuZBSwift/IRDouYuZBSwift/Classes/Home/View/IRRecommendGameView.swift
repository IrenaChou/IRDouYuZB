//
//  IRRecommendGameView.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/18.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit


// MARK:- 常量定义
private let kGameCellID : String = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class IRRecommendGameView: UIView {
    // MARK:- 定义数据属性
    var groups : [IRBaseGameModel]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    

    // MARK:- 系统回调
    override func awakeFromNib() {
        //让当前控件不随着父控件改变
        autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        
        collectionView.register(UINib(nibName: "IRCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin , bottom: 0, right: kEdgeInsetMargin)
    }

}


// MARK: - 提供快速创建的类方法
extension IRRecommendGameView {
    class func recommendGameView() ->IRRecommendGameView {
        return Bundle.main.loadNibNamed("IRRecommendGameView", owner: nil, options: nil)?.first as! IRRecommendGameView
    }
}

// MARK: - 遵守UICollectionView数据源方法
extension IRRecommendGameView : UICollectionViewDataSource {
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! IRCollectionGameCell
        
        let game = groups![indexPath.item]
        cell.baseGame = game
        
        return cell
    }

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }

    
}

// MARK: - 遵守UICollectionView代理方法
extension IRRecommendGameView : UICollectionViewDelegate {
    
}
