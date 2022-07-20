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

class SRProgressManager: NSObject {
    private var items: [String: Any]
    override init() {
        items = [:]
    }
    
    func addProcess<P: SRProgress>(_ progress: P) {
        if let router = self.msgRouter {
            progress.jmSetAssociatedMsgRouter(router: router)
            progress.configProcess()
        }
        let key = P.className()
        items[key] = progress
    }
    
    func progress<P: SRProgress>() -> P? {
        let key = P.className()
        return items[key] as? P
    }
    
    func reset() {
        
    }
    
    deinit {
        items.removeAll()
    }
}
