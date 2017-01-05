//
//  UIBarButtonItem_Extension.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/5.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 便利构造函数
    ///
    /// - Parameters:
    ///   - imageName: 显示normal图片名
    ///   - highImageName: 显示high图片名【非必传】
    ///   - size: 按钮大小【非必传】
   convenience init(imageName: String,highImageName: String = "",size:CGSize = CGSize.zero ) {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: UIControlState.normal)
    
        if highImageName != "" {
            btn.setImage(UIImage.init(named: highImageName), for: UIControlState.highlighted)
        }
    
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }else{
            btn.sizeToFit()
        }
    
        self.init(customView: btn)
    
    }
}
