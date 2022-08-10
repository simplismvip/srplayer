//
//  SRFlowManager.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

public class SRFlowManager: NSObject {
    private var items: [String: Any]
    override init() {
        items = [:]
        super.init()
    }
    
    public func addFlow<P: SRFlow>(_ flow: P) {
        if let router = self.msgRouter {
            flow.jmSetAssociatedMsgRouter(router: router)
            flow.configProcess()
        }
        let key = P.className()
        items[key] = flow
    }
    
    public func model<P: SRFlow>(_ flow: P.Type) -> P.MODEL? {
        let key = flow.className()
        return (items[key] as? P)?.model as? P.MODEL
    }
    
    public func removeProcess<P: SRFlow>(_ progress: P) {
        let key = P.className()
        items.removeValue(forKey: key)
    }
    
    deinit {
        items.removeAll()
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

