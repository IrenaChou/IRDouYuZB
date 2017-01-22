//
//  IRAmuseMenuViewCell.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/20.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

private let kGameCellID : String = "kGameCellID"

class IRAmuseMenuViewCell: UICollectionViewCell {

    var groups : [IRAnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         collectionView.register(UINib(nibName: "IRCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
}
extension IRAmuseMenuViewCell : UICollectionViewDataSource{
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! IRCollectionGameCell
        
        cell.clipsToBounds = true
        cell.baseGame = groups![indexPath.item]
        
        return cell
    }

    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return groups?.count ?? 0
    }

    
}
