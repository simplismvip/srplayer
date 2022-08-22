//
//  Items+Extension.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import AVFAudio

extension SRPlayerNormalController {
    
    func initEdgeItems() {
        // top
        let back = ItemFactory.buttonItem(.back, location: .top, image: "sr_back")
        let living = ItemFactory.buttonItem(.living, location: .top, image: "sr_living")
        let title = ItemFactory.titleItem(title: "星光大道-2022-33", itemStyle: .title)
        let share = ItemFactory.buttonItem(.share, location: .top, image: "sr_share")
        let more = ItemFactory.buttonItem(.more, location: .top, image: "sr_more")
        let scale = ItemFactory.buttonItem(.scale, location: .top, image: "sr_scare_big")
        
        self.barManager.addItem(back)
        if videoType == .living {
            self.barManager.addItem(living)
        }
        self.barManager.addItem(title)
        self.barManager.addItem(scale)
        self.barManager.addItem(share)
        self.barManager.addItem(more)
        
        // bottom
        let play = ItemFactory.buttonItem(.play, location: .bottom, image: "sr_play")
        let curTime = ItemFactory.buttonItem(.curTime, location: .bottom, title: "00:00")
        let next = ItemFactory.buttonItem(.next, location: .bottom, image: "sr_next")
        let tolTime = ItemFactory.buttonItem(.tolTime, location: .bottom, title: "00:00")
        let slider = ItemFactory.sliderItem(value: 0.0)
        let playRate = ItemFactory.buttonItem(.playRate, location: .bottom)
        let series = ItemFactory.buttonItem(.series, location: .bottom, title: "选集")
        let resolve = ItemFactory.buttonItem(.resolve, location: .bottom)
        let fullScrenn = ItemFactory.buttonItem(.fullScrenn, location: .bottom, image: "sr_fullscreen")
        
        self.barManager.addItem(play)
        if videoType == .vod {
            self.barManager.addItem(next)
        }
        self.barManager.addItem(curTime)
        self.barManager.addItem(slider)
        if videoType == .vod {
            self.barManager.addItem(tolTime)
            self.barManager.addItem(playRate)
            self.barManager.addItem(resolve)
        }
        self.barManager.addItem(series)
        self.barManager.addItem(fullScrenn)
        
        // left
        let lockScreen = ItemFactory.buttonItem(.lockScreen, location: .left, image: "sr_unlock")
        self.barManager.addItem(lockScreen)
        
        // right
        let screenShot = ItemFactory.buttonItem(.screenShot, location: .right, image: "sr_capture")
        self.barManager.addItem(screenShot)
    }
    
    func addEdgeSubViews() {
        self.addEdgeArea(.top)
        self.addEdgeArea(.bottom)
        self.addEdgeArea(.left)
        self.addEdgeArea(.right)
        
        self.barManager.layoutItems()
    }
}
