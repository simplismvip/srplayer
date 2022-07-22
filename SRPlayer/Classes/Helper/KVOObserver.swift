//
//  RSObserver.swift
// 
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

protocol KVOObservableProtocol {
    var target: NSObject { get }
    var keyPath: String { get }
    var retainTarget: Bool { get }
    var options: NSKeyValueObservingOptions { get }
}

class RSObserver: KVOObserver {
    typealias Callback = (Any?) -> Void
    var retainSelf: KVOObserver?

    init(parent: KVOObservableProtocol, callback: @escaping Callback) {
        super.init(target: parent.target, keyPath: parent.keyPath, retainTarget: parent.retainTarget, options: parent.options, callback: callback)
        self.retainSelf = self
    }

    override func deallocObserver() {
        super.deallocObserver()
        self.retainSelf = nil
    }

    func add(_ items: inout Set<RSObserver>) {
        items.insert(self)
    }
    
    deinit {
        #if TRACE_RESOURCES
            _ = Resources.decrementTotal()
        #endif
    }
}

final class KVOObservable<Element>: KVOObservableProtocol {
    typealias Element = Element?

    unowned var target: NSObject
    var strongTarget: AnyObject?

    var keyPath: String
    var options: NSKeyValueObservingOptions
    var retainTarget: Bool

    init(object: NSObject, keyPath: String, options: NSKeyValueObservingOptions, retainTarget: Bool) {
        self.target = object
        self.keyPath = keyPath
        self.options = options
        self.retainTarget = retainTarget
        if retainTarget {
            self.strongTarget = object
        }
    }
}

@objc class KVOObserver: NSObject {
    typealias Callback = (Any?) -> Void
    @objc dynamic var target: NSObject?
    @objc dynamic var retainedTarget: NSObject?
    @objc dynamic var keyPath: String = ""
    @objc dynamic var callback: Callback
    
    init(target: NSObject, keyPath: String, retainTarget: Bool, options: NSKeyValueObservingOptions, callback: @escaping Callback ) {
        self.target = target
        self.keyPath = keyPath
        if retainTarget {
            self.retainedTarget = target
        }
        self.callback = callback
        super.init()
        self.target?.addObserver(self, forKeyPath: self.keyPath, options: options, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.callback(change?[.newKey])
    }
    
    public func deallocObserver() {
        self.target?.removeObserver(self, forKeyPath: self.keyPath, context: nil)
        self.target = nil
        self.retainedTarget = nil
    }
}

extension NSObject {
    func observe<Element>(_ type: Element.Type, _ keyPath: String, options: NSKeyValueObservingOptions = [.new, .initial], retainSelf: Bool = true, callback: @escaping (Element?) -> Void) -> RSObserver {
        let kvoObservable = KVOObservable<Element>(object: self, keyPath: keyPath, options: options, retainTarget: retainSelf)
        return RSObserver(parent: kvoObservable) { value in
            callback(value as? Element)
        }
    }
}
