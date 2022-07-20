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
    
    public func setupBarStyle(_ style: ScreenType) {
        top.barStyle = style
        bottom.barStyle = style
        left.barStyle = style
        right.barStyle = style
    }
}
