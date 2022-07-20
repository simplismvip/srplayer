//
//  SRProgress.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

protocol SRModel { }

protocol SRProgress: NSObject {
    associatedtype MODEL: SRModel
    var model: MODEL { set get }
    func configProcess()
}

extension SRProgress {
    func recoverModel(_ model: MODEL) {
        self.model = model
    }
    
    func canResetModel() -> Bool {
        return true
    }
    
    static func className() -> String {
        return NSStringFromClass(Self.self)
    }
}
