//
//  IRPageTitleView.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/6.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit



 // MARK:- 定义协议
 protocol IRPageTitleViewDelegate : class {
    func pageTitleViewDelegate(titleView : IRPageTitleView,selectedIndex index : Int)
}

 // MARK:- 定义常量
private let kScrollLineHeight : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)



 // MARK:- 定义IRPageTitleView类
class IRPageTitleView: UIView {
    // MARK:- 定义属性
    var titles : [String]
    var currentIndex : Int = 0
    //定义代理属性
    weak var delegate : IRPageTitleViewDelegate?
    
    
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
        line.backgroundColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
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
        lineView.backgroundColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        let lineHeight = 0.5
        lineView.frame = CGRect(x: 0, y: frame.height - CGFloat(lineHeight), width: frame.width, height: CGFloat(lineHeight))
        
        addSubview(lineView)
     
        
        
        //添加scrollLine
       scrollView.addSubview(scrollLine)
        
        //获取显示的第一个Label
       guard let lbl = titleLabels.first else { return }
        lbl.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
//       let scrollLineHeight = 1.0
        
       scrollLine.frame = CGRect(x: lbl.frame.origin.x, y: frame.height - CGFloat(1.0), width: lbl.frame.size.width, height: CGFloat(1.0))
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
            lbl.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            lbl.textAlignment = NSTextAlignment.center
            
//            设置lbl的frame
            let lblX = lblWidth * CGFloat(index)
            
            lbl.frame = CGRect(x: lblX, y: 0, width: lblWidth, height: lblHeight)
            scrollView.addSubview(lbl)
            titleLabels.append(lbl)
            
            //为label添加手势
            lbl.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            lbl.addGestureRecognizer(tapGes)
            
            
        }
    }
}


// MARK: - 监听Label的点击
extension IRPageTitleView{
    func titleLabelClick(tapGes: UITapGestureRecognizer){
        
        
        //获取当前label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        //获取之前的label
        let oldLabel = titleLabels[currentIndex]

//        重复点击同一个title，直接返回
        if currentLabel.tag == currentIndex {
            return
        }
        
        
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //保存最新Label下标
        currentIndex = currentLabel.tag

        let scrollLineX = CGFloat(currentIndex) * currentLabel.frame.width
        //调整scrollLine的frame
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pageTitleViewDelegate(titleView: self, selectedIndex: currentIndex)
        
    }
}



// MARK: - 对外开放方法
extension IRPageTitleView{
    func setTitleWith(progress: CGFloat,sourceIndex: Int,targetIndex: Int)  {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //处理滑动渐变
        //总滑动的距离
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //颜色渐变
        //取出变化的范围
//        变化sourceLabel
        let colorDelta = ( kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1 ,kSelectColor.2 - kNormalColor.2)
        
        targetLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        
//        变化targetLabel
        sourceLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        
        currentIndex = targetIndex
    }
}
