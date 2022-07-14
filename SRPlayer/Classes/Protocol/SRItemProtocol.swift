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

public protocol SRItemBarView {
    func configure(_ item: SRPlayerItem)
}

public protocol SRBarManager_P {
    associatedtype TopBarView: SRItemBarView
    associatedtype BottomBarView: SRItemBarView
    associatedtype LeftBarView: SRItemBarView
    associatedtype RightBarView: SRItemBarView
    
    var top: TopBarView { get }
    var bottom: BottomBarView { get }
    var left: LeftBarView { get }
    var right: RightBarView { get }
    
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
