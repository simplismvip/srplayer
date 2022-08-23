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
        let key = P.className()
        if items[key] == nil {
            if let router = self.msgRouter {
                flow.jmSetAssociatedMsgRouter(router: router)
                flow.configFlow()
            }
            items[key] = flow
        } else {
            JMLogger.error("\(key)已经添加过了，不允许❎❎❎重复添加")
        }
    }
    
    public func model<P: SRFlow>(_ flow: P.Type) -> P.MODEL? {
        let key = flow.className()
        return (items[key] as? P)?.model
    }
    
    public func removeFlow<P: SRFlow>(_ flow: P) {
        let key = P.className()
        items.removeValue(forKey: key)
    }
    
    public func removeAllFlow() {
        items.removeAll()
    }
    
    public func replaceFlow<P: SRFlow>(flow: P.Type, with: P) {
        let key = flow.className()
        if items[key] != nil {
            items.removeValue(forKey: key)
        }
        addFlow(with)
    }
    
    deinit {
        items.removeAll()
        JMLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

