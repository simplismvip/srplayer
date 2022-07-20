//
//  SRPlayerItem.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import Foundation

public class SRPlayerItem: SRItem {
    public var size: CGSize
    public var userEnabled: Bool
    public var eventName: String
    public var itemStyle: ItemStyle
    public var edgeInsets: UIEdgeInsets
    public var direction: LayoutDirection
    public var location: LayoutLocation
    public var cornerRadius: CGFloat
    public var className: String
    
    init(_ itemStyle: ItemStyle, location: LayoutLocation) {
        self.size = CGSize(width: 30, height: 30)
        self.userEnabled = true
        self.eventName = itemStyle.rawValue
        self.itemStyle = itemStyle
        self.edgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        self.direction = .anticlockwis
        self.cornerRadius = 8
        self.className = ""
        self.location = location
    }
}

public class SRPlayerEmptyItem: SRPlayerItem {
    init() {
        super.init(.empty, location: .bottom)
        self.className = "SRPlayerEmpty"
    }
}

public class SRPlayerButtonItem: SRPlayerItem {
    public var title: String?
    public var titleColor: UIColor?
    public var image: String?
    public var font: UIFont?
    
    init(_ itemStyle: ItemStyle, location: LayoutLocation, title: String?, image: String?) {
        super.init(itemStyle, location: location)
        self.title = title
        self.image = image
        self.titleColor = UIColor.white
        self.className = "SRPlayerButton"
    }
}

public class SRPlayerSliderItem: SRPlayerItem {
//    public var dragBegin: String?
//    public var draging: String?
//    public var dragEnded: String?
//    public var canceld: String?

    public var firstTrackValue: CGFloat?     /* From 0 to 1 default 0 */
    public var secondTrackValue: CGFloat?     /* From 0 to 1 default 0 */
    public var thumbImage: UIImage?
//    public var thumbSize: CGSize?
    
    init(_ thumbImage: UIImage?, firstValue: CGFloat?, secondValue: CGFloat?) {
        super.init(.slider, location: .bottom)
        self.className = "SRPlayerSlider"
        self.firstTrackValue = firstValue
        self.secondTrackValue = secondValue
    }
}

public class SRPlayerTitleItem: SRPlayerItem {
    public var title: String?
    public var font: UIFont?
    
    init(title: String?, font: UIFont?) {
        super.init(.title, location: .top_left)
        self.title = title
        self.font = font
        self.className = "SRPlayerTitle"
    }
}
