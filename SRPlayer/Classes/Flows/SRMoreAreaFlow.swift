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
//            if let res = result {
//                self.model.items = [res]
//                self.jmSendMsg(msgName: kMsgNameMoreAreaReloadData, info: nil)
//            }
//        }

        if let result = DataParser<Results>.decode(type.name, "json") {
            self.model.items = [result]
            self.jmSendMsg(msgName: kMsgNameMoreAreaReloadData, info: nil)
        }
    }
    
    deinit {
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension SRMoreAreaFlow: SRFlow {
    func configFlow() {
        jmReciverMsg(msgName: kMsgNameMoreAreaRequestData) { [weak self] edgeType in
            if let type = edgeType as? MoreEdgeType {
                self?.request(type)
            }
            return nil
        }
    }
}
