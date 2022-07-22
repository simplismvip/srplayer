//
//  SRPlayerItemFactory.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

struct ItemFactory {

    static func buttonItem(_ itemStyle: ItemStyle, location: LayoutLocation, title: String? = nil, image: String? = nil) -> SRPlayerButtonItem {
        let buttomItem = SRPlayerButtonItem(itemStyle, location: location, title: title, image: image)
        buttomItem.titleColor = UIColor.blue
        if itemStyle == .back {
            
            
        } else if itemStyle == .back {
            
            
        } else if itemStyle == .title {
            buttomItem.title = "太平洋货轮上的老鼠，你说它能游上岸吗?"
            
        } else if itemStyle == .share {
            
            
        } else if itemStyle == .more {
            
            
        } else if itemStyle == .play {
            
            
        } else if itemStyle == .curTime {
            buttomItem.title = "1:23"
            
        } else if itemStyle == .next {
            
            
        } else if itemStyle == .tolTime {
            buttomItem.title = "10:21"
            
        } else if itemStyle == .slider {
            
            
        } else if itemStyle == .play {
            
            
        } else if itemStyle == .sharpness {
            
            
        } else if itemStyle == .playRate {
            buttomItem.title = "1X"
            
        } else if itemStyle == .fullScrenn {
            
            
        } else if itemStyle == .volume {
            
            
        } else if itemStyle == .brightLight {
            
            
        } else if itemStyle == .screenShot {
            
            
        } else if itemStyle == .recording {
            
            
        } else if itemStyle == .lockScreen {
            
            
        }
        return buttomItem
    }
    
    static func titleItem(title: String, font: UIFont?) -> SRPlayerTitleItem {
        return SRPlayerTitleItem(title: title, font: font)
    }
    
    static func sliderItem(firstValue: CGFloat = 0, secondValue: CGFloat) -> SRPlayerSliderItem {
        return SRPlayerSliderItem("sr_progress".image, firstValue: firstValue, secondValue: secondValue)
    }
    
    static func emptyItem() -> SRPlayerEmptyItem {
        return SRPlayerEmptyItem()
    }
}
