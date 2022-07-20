//
//  SRQualitySwitchProcess.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class SRQualitySwitchProcess:  NSObject, SRProgress {
    var model: SRQualitySwitchModel
    override init() {
        self.model = SRQualitySwitchModel()
    }
    
    func configProcess() {
        
    }
}
