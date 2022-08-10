//
//  Action.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/10.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

struct Action {
    var name: String
    var target: NSObject
    var select: Selector
    
    func perform() {
        target.perform(select)
    }
}

class Task {
    var tasks: [String: Action] = [:]
    
    func addAction(_ action: Action) {
        tasks[action.name] = action
    }
    
    func remove(_ name: String) {
        tasks.removeValue(forKey: name)
    }
}
