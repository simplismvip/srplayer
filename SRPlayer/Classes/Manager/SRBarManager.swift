//
//  SRItemProtocol.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import Foundation

public struct SRBarManager: SRBarManager_P {
    public let top: SRPlayerTopBar
    public let bottom: SRPlayerBottomBar
    public let left: SRPlayLeftBar
    public let right: SRPlayerRightBar
    
    init() {
        top = SRPlayerTopBar(frame: .zero)
        bottom = SRPlayerBottomBar(frame: .zero)
        left = SRPlayLeftBar(frame: .zero)
        right = SRPlayerRightBar(frame: .zero)
    }
    
    public func setScreenType(_ type: ScreenType) {
        [top, bottom, left, right].forEach { bar in
            bar.setScreenType(type)
        }
    }
    
    public func layoutItems() {
        [top, bottom, left, right].forEach { bar in
            bar.layoutItems()
        }
    }
    
    public func addItem(_ item: SRPlayerItem) {
        switch item.location {
        case .top:
            top.addItem(item)
        case .bottom:
            bottom.addItem(item)
        case .left:
            left.addItem(item)
        case .right:
            right.addItem(item)
        }
    }
}
