//
//  SRItemProtocol.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import Foundation
import UIKit

public protocol SRControlBar {
    var barType: ControlBarType { get }
    var screenType: ScreenType { get set }
    var items: [SRPlayerItem] { get set }
    var view: UIView { get }
    
    func addItem(_ item: SRPlayerItem)
    func layoutItems()
    func layoutItem(_ itemStyle: ItemStyle)
    func viewFrom<T: Command>(_ item: T) -> UIView?
}

public protocol SRItemButton {
    func configure<T: SRPlayerItem>(_ item: T)
}

public protocol SRBarManager_P {
    var top: SRPlayerTopBar { get }
    var bottom: SRPlayerBottomBar { get }
    var left: SRPlayLeftBar { get }
    var right: SRPlayerRightBar { get }
    func setScreenType(_ type: ScreenType)
}

public protocol SRItem {
    var eventName: String { get set }
    var className: String { get set }
    var itemStyle: ItemStyle { get }
    var direction: Direction { get set }
    var location: Location { get }
    var userEnabled: Bool { get set }
    var margin: SRPlayerItem.Margin { get }
    var size: CGSize { get set }
    var cornerRadius: CGFloat { get set }
    var isHalfHidden: Bool { get set }
}

extension SRItem {
    static func convert(_ item: SRPlayerItem) -> Self {
        return Convert.convert(item)!
    }
}

struct Convert<T: SRItem> {
    static func convert(_ item: SRItem) -> T? {
        return item as? T
    }
}
