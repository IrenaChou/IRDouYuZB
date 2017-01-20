//
//  IRBaseViewModel.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/20.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRBaseViewModel {
    // MARK:- 懒加载属性
    lazy var anchorGroups : [IRAnchorGroup] = [IRAnchorGroup]()
}


// MARK: - 发送网络数据
extension IRBaseViewModel {
    
    func loadData(urlString : String,parameters : [String:Any]? = nil,finishCallBack: @escaping ()->()){
        
        NetworkTools.requestData(type: MethodType.Get, URLString: urlString,parameter: parameters) { (result) in
            
            guard let resultDict = result as? [ String : Any ] else { return }
            guard let dataArray = resultDict["data"] as? [[String:Any]] else {return}
            
            for dict in dataArray{
                let group = IRAnchorGroup(dict: dict)
                if(group.tag_name == "颜值"){
                    continue
                }
                self.anchorGroups.append(group)
            }
            
            finishCallBack()
            
        }
    }
}
