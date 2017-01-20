
//
//  IRAmuseViewModel.swift
//  IRDouYuZBSwift
//
//  Created by zhongdai on 2017/1/20.
//  Copyright © 2017年 ir. All rights reserved.
//

import UIKit

class IRAmuseViewModel : IRBaseViewModel{
}


// MARK: - 发送网络数据
extension IRAmuseViewModel {
    func loadAmuseData(finishCallBack: @escaping ()->()){
        
        super.loadData(urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishCallBack: finishCallBack)
    }
}
