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
    var barType: EdgeAreaUnit { get }
    var screenType: ScreenType { get set }
    var items: [SRPlayerItem] { get set }
    var view: UIView { get }
    
    func layoutItems()
    func layoutItem(_ itemStyle: ItemStyle)
    func viewFrom<T: Command>(_ item: T) -> UIView?
}

//extension SRControlBar {
//    public mutating func addItem(_ item: SRPlayerItem) {
//        self.items.append(item)
//    }
//    
//    public func itemOfStyle(_ style: ItemStyle) -> SRPlayerItem? {
//        return self.items.filter { $0.itemStyle == style }.first
//    }
//    
//    public func sliderItem() -> SRPlayerSliderItem? {
//        return itemOfStyle(.slider) as? SRPlayerSliderItem
//    }
//    
//    public func buttonItem(_ style: ItemStyle) -> SRPlayerButtonItem? {
//        return itemOfStyle(style) as? SRPlayerButtonItem
//    }
//    
//    public func titleItem(_ style: ItemStyle) -> SRPlayerTextItem? {
//        return itemOfStyle(style) as? SRPlayerTextItem
//    }
//}

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

extension SRBarManager {
    public func current(_ type: EdgeAreaUnit) -> UIView {
        switch type {
        case .top:
            return top
        case .left:
            return self.left
        case .bottom:
            return bottom
        case .right:
            return self.right
        }
    }
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
