//
//  IRBaseViewController.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/22.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRBaseViewController: UIViewController {
    
    var contentView : UIView?
    
    fileprivate lazy var animalImageView : UIImageView = {[unowned self] in
        let imgView = UIImageView(image: UIImage(named: "img_loading_1"))
        imgView.center = self.view.center
        imgView.animationImages =
            [UIImage(named: "img_loading_1")!,
             UIImage(named: "img_loading_2")!,
             UIImage(named: "img_loading_3")!,
             UIImage(named: "img_loading_4")!]
        
        imgView.animationDuration = 0.5
        imgView.animationRepeatCount = LONG_MAX
        imgView.autoresizingMask =
            [UIViewAutoresizing.flexibleTopMargin,
            UIViewAutoresizing.flexibleBottomMargin]
        
        return imgView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }

}
extension IRBaseViewController{
    func setupUI(){
        contentView?.isHidden = true
        
        view.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        
        view.addSubview(animalImageView)
        
        animalImageView.startAnimating()
    }
    
    func loadDataFinish(){
        animalImageView.stopAnimating()
        
        animalImageView.isHidden = true
        
        contentView!.isHidden = false
    }
}
