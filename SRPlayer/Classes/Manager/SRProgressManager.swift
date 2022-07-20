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

class SRProgressManager {
    private var items: [String: JMWeakBox<NSObject>]
    init() {
        items = [:]
    }
    
    func updateProgress<P: SRProgress>(_ progress: P) {
        let key = P.className()
        items[key] = JMWeakBox(progress)
    }
    
    func progress<P: SRProgress>() -> P? {
        let key = P.className()
        return items[key]?.weakObjc as? P
    }
    
    func reset() {
        
    }
}
