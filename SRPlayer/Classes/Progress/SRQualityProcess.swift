//
//  SRQualitySwitchProcess.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class SRQualityProcess: NSObject, SRProgress {
    var model: SRQualityModel
    override init() {
        self.model = SRQualityModel()
    }
    
    func configProcess() {
        
    }
    
    deinit {
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}