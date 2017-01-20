//
//  IRGameViewModel.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/19.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRGameViewModel {
    // MARK:- 懒加载属性
    lazy var games : [IRGameModel] = [IRGameModel]()
}

extension IRGameViewModel{
    
    func loadAllGameData(finishedCallBack: @escaping ()->()) {
        NetworkTools.requestData(type: MethodType.Get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameter: ["shortName":"game"]) { (result) in
            
            
            guard let resultDict = result as? [String:Any] else{ return }
            
            guard let dataArray = resultDict["data"] as? [[String:Any]] else{
                return
            }
            
            for dict in dataArray{
              self.games.append(IRGameModel(dict: dict))
            }
            
            finishedCallBack()
        }
    }
}
