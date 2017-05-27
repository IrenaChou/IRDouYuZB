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
private let kScrollLineHeight : CGFloat = 3.0
private let kScrollLineWidth : CGFloat = 30.0
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)




 // MARK:- 定义IRPageTitleView类
class IRPageTitleView: UIView {
    // MARK:- 定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    fileprivate var margin : CGFloat = 0
    
    
    weak var delegate : IRPageTitleViewDelegate?
    
    
    let gradientColors: [CGColor] = [UIColor.yellow.cgColor, UIColor.red.cgColor,UIColor.yellow.cgColor, UIColor.red.cgColor]
    

    lazy var gradentLayzer : CAGradientLayer = {

        //创建CAGradientLayer实例并设置参数
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = self.gradientColors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        return gradientLayer;
    }()
    
    // MARK:- 懒加载属性
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.showsHorizontalScrollIndicator = false
//      scrollsToTop == YES的控件滚动返回至顶部
        scrollV.scrollsToTop = false
//        跳过内容的边缘，再回来
        scrollV.bounces = false
        return scrollV
    }()
    
    
    /// 滚动的线
    fileprivate lazy var scrollLine : UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.yellow
        

        return line
    }()
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    
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
        
        //获取显示的第一个Label
       guard let firstLbl = titleLabels.first else { return }
        
        firstLbl.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)

        
        let templabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
        templabel.text = firstLbl.text;
        templabel.sizeToFit()
        margin = firstLbl.frame.width / 2 - templabel.frame.width / 2
        

        scrollLine.frame = CGRect(x: (firstLbl.frame.width - templabel.frame.width)*0.5 , y: frame.height - kScrollLineHeight, width: templabel.frame.width, height: kScrollLineHeight)

//       scrollLine.frame = CGRect(x: lbl.frame.origin.x, y: frame.height - CGFloat(kScrollLineHeight), width: lbl.frame.size.width, height: kScrollLineHeight)
        
        //update
//        scrollLine.frame = CGRect(x: firstLbl.frame.origin.x, y: frame.height - CGFloat(kScrollLineHeight), width: kScrollLineWidth, height: kScrollLineHeight)
        
        //添加scrollLine
        scrollView.addSubview(scrollLine)

//        scrollLine.center = CGPoint(x: firstLbl.center.x, y: scrollLine.center.y)

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
  @objc fileprivate func titleLabelClick(tapGes: UITapGestureRecognizer){
        
        
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
    
//        let scrollLineX = CGFloat(currentIndex) * currentLabel.frame.width
    
    
        //调整scrollLine的frame
        UIView.animate(withDuration: 0.15) {
//            self.scrollLine.frame.origin.x = scrollLineX
            self.scrollLine.center = CGPoint(x: currentLabel.center.x, y: self.scrollLine.center.y)
        }
        
        //通知代理
        delegate?.pageTitleViewDelegate(titleView: self, selectedIndex: currentIndex)
        
    }
}



// MARK: - 对外开放方法
extension IRPageTitleView{
    
    /// 当滑动的时候会执行此方法
    ///
    /// - Parameters:
    ///   - progress: 进度
    ///   - sourceIndex: 原index
    ///   - targetIndex: 目标index
    func setTitleWith(progress: CGFloat,sourceIndex: Int,targetIndex: Int)  {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //处理滑动渐变
        //总滑动的距离
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress

//        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
//        scrollLine.center = CGPoint(x: sourceLabel.center.x, y: scrollLine.center.y)

        // 判断移动的时候线变长 update
//        scrollLine.frame.size.width = sourceLabel.frame.origin.x + moveX + kScrollLineWidth

        //处理下划线变长变短
        let templabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
        templabel.text = sourceLabel.text;
        templabel.sizeToFit()

        
        let isLimit : Bool = moveX == targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        
        if !isLimit {
            
            if moveX > 0  {
                
                scrollLine.frame.size.width = templabel.frame.size.width + (templabel.frame.size.width + self.margin * 2) * progress * 2
                
                //判定下划线是否跳跃
                if progress < 0.5 {
                    print("大")
                    scrollLine.backgroundColor = UIColor.clear
                    self.gradentLayzer.colors = [UIColor.yellow.cgColor,UIColor.red.cgColor]
                    
                    scrollLine.frame.size.width = templabel.frame.size.width + (templabel.frame.size.width + self.margin * 2) * progress * 2
                    scrollLine.frame.origin.x = sourceLabel.frame.origin.x + margin
                }else{
                    print("小")
//                    scrollLine.backgroundColor = UIColor.orange
                    self.gradentLayzer.colors = [UIColor.clear.cgColor]
                    scrollLine.backgroundColor = UIColor(cgColor: self.gradientColors[currentIndex])
                    
                    scrollLine.frame.size.width = templabel.frame.size.width + (templabel.frame.size.width + self.margin * 2) - (templabel.frame.size.width + self.margin * 2) * (progress * 2 - 1)
                    scrollLine.frame.origin.x = sourceLabel.frame.origin.x + margin + (templabel.frame.size.width + self.margin * 2) * (progress * 2 - 1)
                }
                
            }else{
                
                if progress < 0.5 {
                    scrollLine.backgroundColor = UIColor.clear
                    self.gradentLayzer.colors = [UIColor.yellow.cgColor,UIColor.red.cgColor]

                    
                    scrollLine.frame.size.width = templabel.frame.size.width + (templabel.frame.size.width + self.margin * 2) * progress * 2
                    scrollLine.frame.origin.x = targetLabel.frame.origin.x + margin - (templabel.frame.size.width + self.margin * 2) * (progress * 2 - 1)
                    
                }else{
                    self.gradentLayzer.colors = [UIColor.clear.cgColor]
                    scrollLine.backgroundColor = UIColor(cgColor: self.gradientColors[currentIndex])

                    scrollLine.frame.size.width = templabel.frame.size.width + (templabel.frame.size.width + self.margin * 2) - (templabel.frame.size.width + self.margin * 2) * (progress * 2 - 1)
                    scrollLine.frame.origin.x = targetLabel.frame.origin.x + margin
                }
                
            }
        }
        
        //颜色渐变
        //取出变化的范围
//        变化sourceLabel
        let colorDelta = ( kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1 ,kSelectColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
//        print("sourceLabel === \(sourceLabel.textColor)")
//        变化targetLabel
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        
//        print("targetLabel === \(targetLabel.textColor)")
        //设置其frame以及插入view的layer
        self.gradentLayzer.frame = scrollLine.bounds
        scrollLine.layer.insertSublayer(self.gradentLayzer, at: 0)

       
        //渐变
        currentIndex = targetIndex
    }
}
