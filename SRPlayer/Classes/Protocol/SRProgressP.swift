//
//  SRProgress.swift
//  Pods-SRPlayer_Example
//
//  Created by jh on 2022/7/18.
//

import UIKit

protocol SRModelP: NSObject { }

protocol SRProgressP: NSObject {
    associatedtype MODEL: SRModelP
    var model: MODEL { set get }
    func configProcess()
}

extension SRProgressP {
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
