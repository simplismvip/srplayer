//
//  SRPlayerItemFactory.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//

import UIKit

struct ItemFactory {

    static func buttonItem(_ itemStyle: ItemStyle, location: LayoutLocation, title: String? = nil, image: String? = nil) -> SRPlayerButtonItem {
        let buttomItem = SRPlayerButtonItem(itemStyle, location: location, title: title, image: image)
        
        if itemStyle == .back {
            
            
        } else if itemStyle == .back {
            
            
        } else if itemStyle == .title {
            
            
        } else if itemStyle == .share {
            
            
        } else if itemStyle == .more {
            
            
        } else if itemStyle == .play {
            
            
        } else if itemStyle == .curTime {
            
            
        } else if itemStyle == .next {
            
            
        } else if itemStyle == .tolTime {
            
            
        } else if itemStyle == .slider {
            
            
        } else if itemStyle == .play {
            
            
        } else if itemStyle == .sharpness {
            
            
        } else if itemStyle == .playRate {
            
            
        } else if itemStyle == .fullScrenn {
            
            
        } else if itemStyle == .volume {
            
            
        } else if itemStyle == .brightLight {
            
            
        } else if itemStyle == .screenShot {
            
            
        } else if itemStyle == .recording {
            
            
        } else if itemStyle == .lockScreen {
            
            
        }
        return buttomItem
    }
}
