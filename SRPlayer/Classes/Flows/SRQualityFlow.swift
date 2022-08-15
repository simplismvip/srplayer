//
//  SRQualityFlow.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class SRQualityFlow: NSObject, SRFlow {
    var model: SRQualityModel
    override init() {
        self.model = SRQualityModel()
    }
    
    func configFlow() {
        
    }
    
    public func willRemoveFlow() {
        
    }
    
    public func didRemoveFlow(){
        
    }
    
    deinit {
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}
