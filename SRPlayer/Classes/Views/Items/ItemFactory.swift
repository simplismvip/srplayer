//
//  SRPlayerItemFactory.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public struct ItemFactory {

    public static func buttonItem(_ itemStyle: ItemStyle, location: Location, title: String? = nil, image: String? = nil) -> SRPlayerButtonItem {
        let item = SRPlayerButtonItem(itemStyle, direction: .clockwise, location: location, title: title, image: image)
        if itemStyle == .back {
            item.image = "sr_back"
            
        } else if itemStyle == .title {
            item.title = title
            item.titleColor = UIColor.white
            item.font = UIFont.jmRegular(10)
            
        } else if itemStyle == .mirro {
            item.direction = .anticlockwis
            item.image = "sr_mirror"
            
        } else if itemStyle == .scale {
            item.direction = .anticlockwis
            item.isHalfHidden = true
            item.image = "sr_scare_big"
            
        } else if itemStyle == .share {
            item.direction = .anticlockwis
            item.image = "sr_share"
            // item.isHalfHidden = true
            
        } else if itemStyle == .more {
            item.direction = .anticlockwis
            item.isHalfHidden = true
            item.image = "sr_more"
            
        } else if itemStyle == .play {
            item.image = "sr_play"
            
        } else if itemStyle == .curTime {
            item.title = "00:00"
            item.titleColor = UIColor.white
            item.font = UIFont.jmRegular(12)
            item.size = CGSize(width: 0, height: 34)
            item.isUserInteractionEnabled = false
            
        } else if itemStyle == .next {
            item.image = "sr_next"
            item.isHalfHidden = true

        } else if itemStyle == .tolTime {
            item.title = "00:00"
            item.titleColor = UIColor.white
            item.direction = .anticlockwis
            item.font = UIFont.jmRegular(12)
            item.size = CGSize(width: 0, height: 34)
            item.isUserInteractionEnabled = false
            
        } else if itemStyle == .sharpness {
            item.direction = .anticlockwis
            item.isHalfHidden = true
            
        } else if itemStyle == .playRate {
            item.title = "倍速"
            item.titleColor = UIColor.white
            item.direction = .anticlockwis
            item.font = UIFont.jmRegular(14)
            item.isHalfHidden = true
            item.size = CGSize(width: 0, height: 34)
            
        } else if itemStyle == .fullScrenn {
            item.direction = .anticlockwis
            item.image = "sr_fullscreen"
            
        } else if itemStyle == .series {
            item.title = "选集"
            item.titleColor = UIColor.white
            item.direction = .anticlockwis
            item.font = UIFont.jmRegular(14)
            item.size = CGSize(width: 0, height: 34)
            item.isHalfHidden = true
            
        } else if itemStyle == .resolve {
            item.title = "清晰度"
            item.titleColor = UIColor.white
            item.direction = .anticlockwis
            item.font = UIFont.jmRegular(14)
            item.size = CGSize(width: 0, height: 34)
            item.isHalfHidden = true
            
        } else if itemStyle == .screenShot {
            item.isHalfHidden = true
            item.image = "sr_capture"
            
        } else if itemStyle == .recording {
            // item.isHalfHidden = true
            item.image = "sr_capture"
            
        } else if itemStyle == .lockScreen {
            item.image = "sr_unlock"
            
        } else if itemStyle == .living {
            let images = (1...4)
                .map { "sr_back_live_\($0)".image }
                .compactMap { $0 }
            item.image = "sr_living"
            item.animatedImage = UIImage.animatedImage(with: images, duration: 1)
            item.size = CGSize(width: 43, height: 34)
            
        }
        return item
    }
    
    static func titleItem(title: String, itemStyle: ItemStyle) -> SRPlayerTextItem {
        let item = SRPlayerTextItem(title: title, itemStyle: itemStyle, direction: .stretchable, location: .top, font: UIFont.jmRegular(15))
        return item
    }
    
    static func sliderItem(value: CGFloat = 0) -> SRPlayerSliderItem {
        return SRPlayerSliderItem("sr_progress".image, value: value)
    }
}
