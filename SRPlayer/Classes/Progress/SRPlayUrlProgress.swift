//
//  SRPlayUrlProgress.swift
//  Pods-SRPlayer_Example
//
//  Created by jh on 2022/7/18.
//

import UIKit

class SRPlayUrlProgress: NSObject, SRProgress {
    var model: SRPlayUrlModel
    override init() {
        self.model = SRPlayUrlModel()
    }
    
    func configProcess() {
        
    }
}
