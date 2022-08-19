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
        let title = ItemFactory.titleItem(title: "", itemStyle: .title)
        let share = ItemFactory.buttonItem(.share, location: .top, image: "sr_share")
        let more = ItemFactory.buttonItem(.more, location: .top, image: "sr_more")
        let mirro = ItemFactory.buttonItem(.mirro, location: .top, image: "sr_mirror")
        let scale = ItemFactory.buttonItem(.scale, location: .top, image: "sr_scare_big")
        
        self.barManager.top.addItem(back)
        self.barManager.top.addItem(title)
        self.barManager.top.addItem(mirro)
        self.barManager.top.addItem(scale)
        self.barManager.top.addItem(share)
        self.barManager.top.addItem(more)
        
        // bottom
        let play = ItemFactory.buttonItem(.play, location: .bottom, image: "sr_play")
        let curTime = ItemFactory.buttonItem(.curTime, location: .bottom, title: "00:00")
        let next = ItemFactory.buttonItem(.next, location: .bottom, image: "sr_next")
        let tolTime = ItemFactory.buttonItem(.tolTime, location: .bottom, title: "00:00")
        let slider = ItemFactory.sliderItem(value: 0.0)
        let playRate = ItemFactory.buttonItem(.playRate, location: .bottom)
        let series = ItemFactory.buttonItem(.series, location: .bottom)
        let resolve = ItemFactory.buttonItem(.resolve, location: .bottom)
        let fullScrenn = ItemFactory.buttonItem(.fullScrenn, location: .bottom, image: "sr_fullscreen")
        
//        let sharpness = ItemFactory.buttonItem(.sharpness)
//        let volume = ItemFactory.buttonItem(.volume, image: "sr_volume")
//        let brightLight = ItemFactory.buttonItem(.brightLight, title: nil, image: "sr_more")
        self.barManager.bottom.addItem(play)
        self.barManager.bottom.addItem(next)
        self.barManager.bottom.addItem(curTime)
        
        self.barManager.bottom.addItem(slider)
        self.barManager.bottom.addItem(tolTime)
        self.barManager.bottom.addItem(playRate)
        self.barManager.bottom.addItem(series)
        self.barManager.bottom.addItem(resolve)
        self.barManager.bottom.addItem(fullScrenn)
        
        // left
        let lockScreen = ItemFactory.buttonItem(.lockScreen, location: .left, image: "sr_unlock")
        self.barManager.left.addItem(lockScreen)
        
        // right
        let screenShot = ItemFactory.buttonItem(.screenShot, location: .right, image: "sr_capture")
//        let recording = ItemFactory.buttonItem(.recording, location: .right, image: "sr_recording")
        self.barManager.right.addItem(screenShot)
//        self.barManager.right.addItem(recording)
    }
    
    func addEdgeSubViews() {
        self.addEdgeArea(.top)
        self.addEdgeArea(.bottom)
        self.addEdgeArea(.left)
        self.addEdgeArea(.right)
        
        self.barManager.top.layoutItems()
        self.barManager.bottom.layoutItems()
        self.barManager.left.layoutItems()
        self.barManager.right.layoutItems()
    }
}

extension SRPlayerLivingController {
    
    func initEdgeItems() {
        // top
        let back = ItemFactory.buttonItem(.back, location: .top, image: "sr_back")
        let living = ItemFactory.buttonItem(.living, location: .top, image: "sr_mirror")
        let title = ItemFactory.titleItem(title: "", itemStyle: .title)
        let share = ItemFactory.buttonItem(.share, location: .top, image: "sr_share")
        let more = ItemFactory.buttonItem(.more, location: .top, image: "sr_more")
        let scale = ItemFactory.buttonItem(.scale, location: .top, image: "sr_scare_big")
        
        self.barManager.top.addItem(back)
        self.barManager.top.addItem(living)
        
        self.barManager.top.addItem(title)
        self.barManager.top.addItem(scale)
        self.barManager.top.addItem(share)
        self.barManager.top.addItem(more)
        
        // bottom
        let play = ItemFactory.buttonItem(.play, location: .bottom, image: "sr_play")
        let curTime = ItemFactory.buttonItem(.curTime, location: .bottom, title: "00:00")
        let next = ItemFactory.buttonItem(.next, location: .bottom, image: "sr_next")
        let tolTime = ItemFactory.buttonItem(.tolTime, location: .bottom, title: "00:00")
        let slider = ItemFactory.sliderItem(value: 0.0)
        let playRate = ItemFactory.buttonItem(.playRate, location: .bottom)
        let series = ItemFactory.buttonItem(.series, location: .bottom)
        let resolve = ItemFactory.buttonItem(.resolve, location: .bottom)
        let fullScrenn = ItemFactory.buttonItem(.fullScrenn, location: .bottom, image: "sr_fullscreen")
        
        self.barManager.bottom.addItem(play)
        self.barManager.bottom.addItem(next)
        self.barManager.bottom.addItem(curTime)
        
        self.barManager.bottom.addItem(slider)
        self.barManager.bottom.addItem(tolTime)
        self.barManager.bottom.addItem(playRate)
        self.barManager.bottom.addItem(series)
        self.barManager.bottom.addItem(resolve)
        self.barManager.bottom.addItem(fullScrenn)
        
        // left
        let lockScreen = ItemFactory.buttonItem(.lockScreen, location: .left, image: "sr_unlock")
        self.barManager.left.addItem(lockScreen)
        
        // right
        let screenShot = ItemFactory.buttonItem(.screenShot, location: .right, image: "sr_capture")
        self.barManager.right.addItem(screenShot)
    }
    
    func addEdgeSubViews() {
        self.addEdgeArea(.top)
        self.addEdgeArea(.bottom)
        self.addEdgeArea(.left)
        self.addEdgeArea(.right)
        
        self.barManager.top.layoutItems()
        self.barManager.bottom.layoutItems()
        self.barManager.left.layoutItems()
        self.barManager.right.layoutItems()
    }
}
