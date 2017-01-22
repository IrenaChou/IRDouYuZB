//
//  IRFunnyViewModel.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/22.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRFunnyViewModel : IRBaseViewModel {
    
}

extension IRFunnyViewModel{
    func funnyLoadData(finished: @escaping () -> ()){
        self.loadData(isGroupData: false,urlString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit":30,"offset":0], finishCallBack: finished)
    }
}
