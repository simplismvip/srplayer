//
//  SRProgress.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public protocol SRModel { }

public protocol SRFlow: NSObject {
    associatedtype MODEL: SRModel
    var model: MODEL { set get }
    func configProcess()
}

extension SRFlow {
    public  func recoverModel(_ model: MODEL) {
        self.model = model
    }
    
    public func canResetModel() -> Bool {
        return true
    }
    
    public static func className() -> String {
        return NSStringFromClass(Self.self)
    }
}
