//
//  Action.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/10.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public struct Action {
    var name: String
    let target: NSObject
    let selector: Selector
    
    init(target: NSObject, selector: Selector) {
        self.target = target
        self.selector = selector
        self.name = ""
    }
    
    public func perform() {
        target.perform(selector)
    }
    
    public func perform(_ with: Any) {
        target.perform(selector, with: with)
    }
    
    public func perform(_ with: Any, delay: TimeInterval) {
        target.perform(selector, with: with, afterDelay: delay)
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

class Test: NSObject {
    func testAction() {
        let action = Action(target: self, selector: #selector(testmsg))
        action.perform()
    }
    
    @objc func testmsg() {
        print("testmsg")
    }
}

protocol ActionP {
    
}
