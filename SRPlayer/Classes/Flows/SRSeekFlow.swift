//
//  SRSeekFlow.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

class SRSeekFlow: NSObject {
    var model: SRSeekModel
    
    override init() {
        self.model = SRSeekModel()
    }
    
    public func willRemoveFlow() {
        
    }
    
    public func didRemoveFlow(){
        
    }
    
    deinit {
        JMLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension SRSeekFlow: SRFlow {
    func configFlow() {
        
    }
}
