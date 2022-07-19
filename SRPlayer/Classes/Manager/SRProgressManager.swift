//
//  SRProgressManager.swift
//  Pods-SRPlayer_Example
//
//  Created by jh on 2022/7/18.
//

import UIKit
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
