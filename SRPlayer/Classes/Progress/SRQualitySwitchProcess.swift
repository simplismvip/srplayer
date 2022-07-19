//
//  SRQualitySwitchProcess.swift
//  Pods-SRPlayer_Example
//
//  Created by jh on 2022/7/18.
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
