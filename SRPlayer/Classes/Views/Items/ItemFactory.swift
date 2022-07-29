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
            item.title = "1:23"
            item.titleColor = UIColor.white
            item.font = UIFont.jmRegular(10)
            item.size = CGSize(width: 0, height: 34)
        } else if itemStyle == .next {
            item.isHalfHidden = true

        } else if itemStyle == .tolTime {
            item.title = "10:21"
            item.titleColor = UIColor.white
            item.direction = .anticlockwis
            item.font = UIFont.jmRegular(10)
            item.size = CGSize(width: 0, height: 34)
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
    
    static func titleItem(title: String, font: UIFont?) -> SRPlayerTitleItem {
        return SRPlayerTitleItem(title: title, font: font)
    }
    
    static func sliderItem(value: CGFloat = 0) -> SRPlayerSliderItem {
        return SRPlayerSliderItem("sr_progress".image, value: value)
    }
}
