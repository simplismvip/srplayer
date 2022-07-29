//
//  SRPlayerItem.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import Foundation

public class SRPlayerItem: NSObject, SRItem {
    @objc dynamic public var size: CGSize
    @objc dynamic public var userEnabled: Bool
    public var margin: Margin
    public var eventName: String
    public var itemStyle: ItemStyle
    public var direction: Direction
    public var location: Location
    public var cornerRadius: CGFloat
    public var className: String
    
    var view: UIView? {
        guard let barView = InitClass<UIView>.instance(className) else {
            return nil
        }
        (barView as? SRItemButton)?.configure(self)
        
        (barView as? SRPlayerButton)?.jmAddAction { [weak self] _ in
            barView.jmRouterEvent(eventName: self?.eventName ?? "", info: self)
        }
        
        return barView
    }
    
    init(_ itemStyle: ItemStyle, direction: Direction, location: Location) {
        self.cornerRadius = 8
        self.size = CGSize(width: 34, height: 34)
        self.margin = Margin(top: 3, bottom: 3, left: 10, right: 10, space: 5)
        self.userEnabled = true
        self.eventName = itemStyle.rawValue
        self.itemStyle = itemStyle
        self.direction = direction
        self.location = location
        self.className = "SRPlayerItem"
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
    
    init(_ itemStyle: ItemStyle, direction: Direction, location: Location, title: String?, image: String?) {
        super.init(itemStyle, direction: .clockwise, location: location)
        self.title = title
        self.image = image
        self.titleColor = UIColor.white
        self.tintColor = UIColor.blue
        self.className = "SRPlayerButton"
    }
}

public class SRPlayerSliderItem: SRPlayerItem {
//    public var dragBegin: String?
//    public var draging: String?
//    public var dragEnded: String?
    public let minTintColor: UIColor
    public let maxTintColor: UIColor
    @objc dynamic public var value: CGFloat = 0     /* From 0 to 1 default 0 */
    @objc dynamic public var secondTrackValue: CGFloat = 0     /* From 0 to 1 default 0 */
    @objc dynamic public var thumbImage: UIImage?

    init(_ thumbImage: UIImage?, value: CGFloat, secondValue: CGFloat) {
        self.minTintColor = UIColor.white
        self.maxTintColor = UIColor.gray
        super.init(.slider, direction: .stretchable, location: .bottom)
        self.className = "SRPlayerSlider"
        self.value = value
        self.secondTrackValue = secondValue
    }
}

public class SRPlayerTitleItem: SRPlayerItem {
    @objc dynamic public var title: String?
    @objc dynamic public var font: UIFont?
    
    init(title: String?, font: UIFont?) {
        super.init(.title, direction: .stretchable, location: .top)
        self.title = title
        self.font = font
        self.className = "SRPlayerTitle"
    }
}
