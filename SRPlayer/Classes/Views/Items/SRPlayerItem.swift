//
//  SRPlayerItem.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import Foundation
import UIKit

public class SRPlayerItem: NSObject, SRItem {
    @objc dynamic public var size: CGSize
    @objc dynamic public var userEnabled: Bool
    @objc dynamic public var isHalfHidden: Bool
    public var margin: Margin
    public var eventName: String
    public var itemStyle: ItemStyle
    public var direction: Direction
    public var location: Location
    public var cornerRadius: CGFloat
    public var className: String
    
    // item 对应的view
    var view: UIView? {
        let barView = InitClass<UIView>.instance(className)
        if let btn = (barView as? SRPlayerButton), let item = self as? SRPlayerButtonItem {
            btn.configure(item)
            if !self.eventName.isEmpty {
                btn.jmAddAction { [weak self] _ in
                    barView?.jmRouterEvent(eventName: self?.eventName ?? "", info: self)
                }
            }
        } else if let btn = (barView as? SRPlayerSlider), let item = self as? SRPlayerSliderItem {
            btn.configure(item)
        } else if let btn = (barView as? SRPlayerText), let item = self as? SRPlayerTextItem {
            btn.configure(item)
        }
        return barView
    }
    
    init(_ itemStyle: ItemStyle, direction: Direction, location: Location) {
        self.cornerRadius = 8
        self.size = CGSize(width: 34, height: 34)
        self.margin = Margin(top: 3, bottom: 3, left: 10, right: 10, space: 5)
        self.userEnabled = true
        self.isHalfHidden = false
        self.eventName = itemStyle.rawValue
        self.itemStyle = itemStyle
        self.direction = direction
        self.location = location
        self.className = ""
    }
    
    public struct Margin {
        var top: Int
        var bottom: Int
        var left: Int
        var right: Int
        var space: Int
    }
}

public class SRPlayerButtonItem: SRPlayerItem {
    @objc dynamic public var title: String?
    @objc dynamic public var titleColor: UIColor?
    @objc dynamic public var tintColor: UIColor?
    @objc dynamic public var image: String?
    @objc dynamic public var font: UIFont?
    @objc dynamic public var isUserInteractionEnabled: Bool
    @objc dynamic public var isLockScreen: Bool
    public var animatedImage: UIImage?
    
    init(_ itemStyle: ItemStyle, direction: Direction, location: Location, title: String?, image: String?) {
        self.isUserInteractionEnabled = true
        self.isLockScreen = false
        super.init(itemStyle, direction: .clockwise, location: location)
        self.title = title
        self.image = image
        self.titleColor = UIColor.white
        self.tintColor = UIColor.white
        self.className = "SRPlayerButton"
    }
}

public class SRPlayerSliderItem: SRPlayerItem {    
    /* From 0 to 1 default 0 */
    @objc dynamic public var value: CGFloat
    @objc dynamic public var thumbImage: UIImage?
    public let minTintColor: UIColor
    public let maxTintColor: UIColor
    
    init(_ thumbImage: UIImage?, value: CGFloat) {
        self.minTintColor = UIColor.white
        self.maxTintColor = UIColor.gray
        self.value = 0
        super.init(.slider, direction: .stretchable, location: .bottom)
        self.className = "SRPlayerSlider"
        self.value = value
    }
}

public class SRPlayerTextItem: SRPlayerItem {
    @objc dynamic public var title: String?
    public var font: UIFont?
    init(title: String?, itemStyle: ItemStyle, direction: Direction, location: Location, font: UIFont?) {
        super.init(itemStyle, direction: direction, location: location)
        self.title = title
        self.font = font
        self.className = "SRPlayerText"
    }
}
