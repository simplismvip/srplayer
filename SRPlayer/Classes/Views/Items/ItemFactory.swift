//
//  SRPlayerItemFactory.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

struct ItemFactory {

    static func buttonItem(_ itemStyle: ItemStyle, location: Location, title: String? = nil, image: String? = nil) -> SRPlayerButtonItem {
        let item = SRPlayerButtonItem(itemStyle, direction: .clockwise, location: location, title: title, image: image)
        if itemStyle == .back {
            
            
        } else if itemStyle == .title {
            item.title = "太平洋货轮上的老鼠，你说它能游上岸吗?"
            item.titleColor = UIColor.white
            item.font = UIFont.jmRegular(10)
//            item.isHalfHidden = true
        } else if itemStyle == .share {
            item.direction = .anticlockwis
            item.isHalfHidden = true
        } else if itemStyle == .more {
            item.direction = .anticlockwis
            
        } else if itemStyle == .play {
            
            
        } else if itemStyle == .curTime {
            item.title = title
            item.titleColor = UIColor.white
            item.font = UIFont.jmRegular(12)
            item.size = CGSize(width: 0, height: 34)
            item.isUserInteractionEnabled = false
        } else if itemStyle == .next {
            item.isHalfHidden = true

        } else if itemStyle == .tolTime {
            item.title = title
            item.titleColor = UIColor.white
            item.direction = .anticlockwis
            item.font = UIFont.jmRegular(12)
            item.size = CGSize(width: 0, height: 34)
            item.isUserInteractionEnabled = false
        } else if itemStyle == .slider {
            
            
        } else if itemStyle == .play {
            
            
        } else if itemStyle == .sharpness {
            item.direction = .anticlockwis
            item.isHalfHidden = true
        } else if itemStyle == .playRate {
            item.title = "1X"
            item.titleColor = UIColor.white
            item.direction = .anticlockwis
            item.font = UIFont.jmRegular(12)
            item.isUserInteractionEnabled = false
            item.isHalfHidden = true
        } else if itemStyle == .fullScrenn {
            
            item.direction = .anticlockwis
            
        } else if itemStyle == .volume {
            
            
        } else if itemStyle == .brightLight {
            
            
        } else if itemStyle == .screenShot {
            item.isHalfHidden = true
            
        } else if itemStyle == .recording {
//            item.isHalfHidden = true
        } else if itemStyle == .lockScreen {
            
        }
        return item
    }
    
    static func titleItem(title: String, itemStyle: ItemStyle) -> SRPlayerTextItem {
        if itemStyle == .curTime {
            let item = SRPlayerTextItem(text: title, itemStyle: itemStyle, direction: .clockwise, location: .bottom, font: UIFont.jmRegular(12))
            item.size = CGSize(width: 0, height: 34)
            return item
        } else if itemStyle == .title {
            let item = SRPlayerTextItem(text: title, itemStyle: itemStyle, direction: .stretchable, location: .top, font: UIFont.jmRegular(15))
            return item
        } else {
            let item = SRPlayerTextItem(text: title, itemStyle: itemStyle, direction: .anticlockwis, location: .bottom, font: UIFont.jmRegular(12))
            item.size = CGSize(width: 0, height: 34)
            return item
        }
    }
    
    static func sliderItem(value: CGFloat = 0) -> SRPlayerSliderItem {
        return SRPlayerSliderItem("sr_progress".image, value: value)
    }
}
