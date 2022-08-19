//
//  SRMoreDataRequest.swift
//  SRPlayer_Example
//
//  Created by JunMing on 2022/8/19.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit
import SRPlayer

class SRMoreDataRequest: NSObject, RequestData {
    func request(_ type: MoreEdgeType) {
//        if type == .series {
//            DataParser<MoreResult>.request(path: type.name) { result in
//                if let res = result {
//                    self.jmSendMsg(msgName: kMsgNameMoreAreaRequestDone, info: [res] as MsgObjc)
//                }
//            }
//        } else if type == .playrate {
//            if let result = DataTool<MoreResult>.decode(type.name) {
//                self.jmSendMsg(msgName: kMsgNameMoreAreaRequestDone, info: [result] as MsgObjc)
//            }
//        }
        
        if let result = DataTool<MoreResult>.decode(type.name) {
            self.jmSendMsg(msgName: kMsgNameMoreAreaRequestDone, info: [result] as MsgObjc)
        }
    }
    
    func registerMsg() {
        jmReciverMsg(msgName: kMsgNameMoreAreaRequestOutsideData) { [weak self] moreType in
            if let type = moreType as? MoreEdgeType {
                self?.request(type)
            }
            return nil
        }
    }
}
