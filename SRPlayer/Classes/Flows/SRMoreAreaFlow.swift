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
        if let result = DataParser<MoreResult>.decode(type.name, "json") {
            self.jmSendMsg(msgName: kMsgNameMoreAreaRequestDone, info: [result] as MsgObjc)
        } else {
            // 内部没有数据可提供，抛出到外部请求数据
            self.jmSendMsg(msgName: kMsgNameMoreAreaRequestOutsideData, info: type as MsgObjc)
        }
    }
    
    deinit {
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension SRMoreAreaFlow: SRFlow {
    func configFlow() {
        // 外部请求数据完成返回数据
        jmReciverMsg(msgName: kMsgNameMoreAreaRequestDone) { [weak self] moreItems in
            if let result = moreItems as? [MoreResult] {
                self?.model.items = result
                self?.jmSendMsg(msgName: kMsgNameMoreAreaReloadData, info: nil)
            }
            return nil
        }
        
        // 请求more页面展示数据
        jmReciverMsg(msgName: kMsgNameMoreAreaRequestData) { [weak self] moreType in
            if let type = moreType as? MoreEdgeType {
                self?.request(type)
            }
            return nil
        }
    }
    
    public func willRemoveFlow() {
        
    }
    
    public func didRemoveFlow(){
        
    }
}
