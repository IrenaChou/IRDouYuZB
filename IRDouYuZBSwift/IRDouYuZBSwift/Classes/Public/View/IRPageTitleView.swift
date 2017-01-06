//
//  IRPageTitleView.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/6.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

let kScrollLineHeight : CGFloat = 2


class IRPageTitleView: UIView {
    
    // MARK:- 定义属性
    var titles : [String]
    
    // MARK:- 懒加载属性
    lazy var scrollView : UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.showsHorizontalScrollIndicator = false
//      scrollsToTop == YES的控件滚动返回至顶部
        scrollV.scrollsToTop = false
//        跳过内容的边缘，再回来
        scrollV.bounces = false
        return scrollV
    }()
    /// 滚动的线
    lazy var scrollLine : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.orange
        return line
    }()
    lazy var titleLabels : [UILabel] = [UILabel]()
    
    
    // MARK:- 自定义构造函数
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 设置UI界面
extension IRPageTitleView {
    func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        
//        设置title文字
        setTitleLabels()
        
//        设置底线和滚动的滑块
        setupBottomMenuAddScrollLine()
    }
    
    
    /// 设置底线和滚动的滑块
    private func setupBottomMenuAddScrollLine() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.darkGray
        
        let lineHeight = 0.5
        lineView.frame = CGRect(x: 0, y: frame.height - CGFloat(lineHeight), width: frame.width, height: CGFloat(lineHeight))
        
        addSubview(lineView)
     
        
        
        //添加scrollLine
       scrollView.addSubview(scrollLine)
        
        //获取显示的第一个Label
       guard let lbl = titleLabels.first else { return }
        lbl.textColor = UIColor.orange
       let scrollLineHeight = 1.0
        
       scrollLine.frame = CGRect(x: lbl.frame.origin.x, y: frame.height - CGFloat(scrollLineHeight), width: lbl.frame.size.width, height: CGFloat(scrollLineHeight))
    }
    
    
    /// 设置title对应的label
    private func setTitleLabels(){
        /// 固定值
        let lblWidth = frame.width / CGFloat( titles.count )
        let lblHeight = frame.height - kScrollLineHeight

        
//        遍历数组获取下标和内容
        for (index , title) in titles.enumerated() {
            let lbl = UILabel()
            lbl.text = title
            lbl.tag = index
            lbl.font = UIFont.systemFont(ofSize: 16)
            lbl.textColor = UIColor.darkGray
            lbl.textAlignment = NSTextAlignment.center
            
//            设置lbl的frame
            let lblX = lblWidth * CGFloat(index)
            
            lbl.frame = CGRect(x: lblX, y: 0, width: lblWidth, height: lblHeight)
            scrollView.addSubview(lbl)
            
            titleLabels.append(lbl)
            
        }
    }
}
