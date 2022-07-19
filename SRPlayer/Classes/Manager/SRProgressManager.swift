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
    
    func updateProgress<P: SRProgressP>(_ progress: P) {
        let key = P.className()
        items[key] = JMWeakBox(progress)
    }
    
    func progress<P: SRProgressP>() -> P? {
        let key = P.className()
        return items[key]?.weakObjc as? P
    }
    
    func reset() {
        
    }
}
