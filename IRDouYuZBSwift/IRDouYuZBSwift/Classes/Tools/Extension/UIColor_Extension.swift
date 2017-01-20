//
//  UIColor_Extension.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/6.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    
    /// 随机颜色
    ///
    /// - Returns: UIColor的随机色
    class func randomColor() -> UIColor{
         return
            UIColor(r: CGFloat(arc4random_uniform(256)),
                    g: CGFloat(arc4random_uniform(256)),
                    b: CGFloat(arc4random_uniform(256)))
    }
}
