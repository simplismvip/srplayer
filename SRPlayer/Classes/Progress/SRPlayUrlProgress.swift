//
//  SRPlayUrlProgress.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class SRPlayUrlProgress: NSObject, SRProgress {
    var model: SRPlayUrlModel
    override init() {
        self.model = SRPlayUrlModel()
    }
    
    func configProcess() {
        
    }
    
    deinit {
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}
