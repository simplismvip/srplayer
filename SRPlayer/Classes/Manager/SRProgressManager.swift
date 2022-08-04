//
//  SRProgressManager.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import Combine
import ZJMKit

public class SRProgressManager: NSObject {
    private var items: [String: Any]
    override init() {
        items = [:]
        super.init()
    }
    
    func addProcess<P: SRProgress>(_ progress: P) {
        if let router = self.msgRouter {
            progress.jmSetAssociatedMsgRouter(router: router)
            progress.configProcess()
        }
        let key = P.className()
        items[key] = progress
    }
    
    func model<P: SRProgress>(_ progress: P.Type) -> P.MODEL? {
        let key = progress.className()
        return (items[key] as? P)?.model as? P.MODEL
    }
    
    func removeProcess<P: SRProgress>(_ progress: P) {
        let key = P.className()
        items.removeValue(forKey: key)
    }
    
    deinit {
        items.removeAll()
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

