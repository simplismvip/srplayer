//
//  SRMoreAreaFlow.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/10.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

class SRMoreAreaFlow: NSObject {
    var model: SRMoreAreaModel
    override init() {
        self.model = SRMoreAreaModel()
    }
    
    func request(_ type: MoreEdgeType) {
//        DataParser<Results>.request(path: type.name) { result in
//            if let items = result?.results {
//                self.model.items = items
//            } else {
//                SRLogger.debug("请求失败请重试")
//            }
//        }
//        
//        if let items = DataParser<Results>.decode(type.name, "json")?.results {
//            self.model.items = items
//        }
    }
    
    deinit {
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension SRMoreAreaFlow: SRFlow {
    
    func configFlow() {
        /// 请求数据
        jmReciverMsg(msgName: kMsgNameMoreAreaRequestData) { [weak self] edgeType in
            if let type = edgeType as? MoreEdgeType {
               
                self?.jmSendMsg(msgName: kMsgNameMoreAreaReloadData, info: nil)
            }
            return nil
        }
    }
}
