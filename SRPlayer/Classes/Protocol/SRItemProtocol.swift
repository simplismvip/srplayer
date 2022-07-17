//
//  SRItemProtocol.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//

import Foundation
import UIKit

public protocol SRControlBar {
    var barType: ControlBarType { get }
    var barStyle: ScreenType { get set }
    var items: [SRPlayerItem] { get set }
    var view: UIStackView { get }
    
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
    func setupBarStyle(_ style: ScreenType)
}

public protocol SRItem {
    var eventName: String { get set }
    var className: String { get set }
    var itemStyle: ItemStyle { get }
    var direction: LayoutDirection { get set }
    var location: LayoutLocation { get }
    var userEnabled: Bool { get set }
    var edgeInsets: UIEdgeInsets { get }
    var size: CGSize { get set }
    var cornerRadius: CGFloat { get set }
}
