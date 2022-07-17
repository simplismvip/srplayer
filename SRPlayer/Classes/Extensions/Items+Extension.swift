//
//  EdgeItems+Extension.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//

import UIKit
import AVFAudio

extension SRPlayerController {
    
    func initEdgeItems() {
        let empty = ItemFactory.emptyItem()
        
        // top
        let back = ItemFactory.buttonItem(.back, location: .top_left, image: "sr_back")
        let title = ItemFactory.titleItem(title: "太平洋货轮上的老鼠，你说它能游上岸吗?", font: UIFont.jmRegular(15))
        let share = ItemFactory.buttonItem(.share, location: .top_right, image: "sr_share")
        let more = ItemFactory.buttonItem(.more, location: .top_right, image: "sr_more")
        
        self.barManager.top.addItem(back)
        self.barManager.top.addItem(title)
        self.barManager.top.addItem(empty)
        self.barManager.top.addItem(share)
        self.barManager.top.addItem(more)
        
        // bottom
        let play = ItemFactory.buttonItem(.play, location: .bottom, image: "sr_play")
        let curTime = ItemFactory.buttonItem(.curTime, location: .bottom)
        let next = ItemFactory.buttonItem(.next, location: .bottom, image: "sr_next")
        let tolTime = ItemFactory.buttonItem(.tolTime, location: .bottom)
        let slider = ItemFactory.sliderItem(firstValue: 0.1, secondValue: nil)
        let playRate = ItemFactory.buttonItem(.playRate, location: .bottom)
        let fullScrenn = ItemFactory.buttonItem(.fullScrenn, location: .bottom, image: "sr_fullscrenn")
        
//        let sharpness = ItemFactory.buttonItem(.sharpness)
//        let volume = ItemFactory.buttonItem(.volume, image: "sr_volume")
//        let brightLight = ItemFactory.buttonItem(.brightLight, title: nil, image: "sr_more")
        self.barManager.bottom.addItem(play)
        self.barManager.bottom.addItem(next)
        self.barManager.bottom.addItem(curTime)
        
        self.barManager.bottom.addItem(slider)
        self.barManager.bottom.addItem(playRate)
        self.barManager.bottom.addItem(tolTime)
        self.barManager.bottom.addItem(fullScrenn)
        
        // left
        let lockScreen = ItemFactory.buttonItem(.lockScreen, location: .left, image: "sr_lock")
        self.barManager.left.addItem(lockScreen)
        
        // right
        let screenShot = ItemFactory.buttonItem(.screenShot, location: .right, image: "sr_capture")
        let recording = ItemFactory.buttonItem(.recording, location: .right, image: "sr_recording")
        self.barManager.right.addItem(empty)
        self.barManager.right.addItem(screenShot)
        self.barManager.right.addItem(recording)
        self.barManager.right.addItem(empty)
    }
    
    func addEdgeSubViews() {
        self.addEdgeAreaTop(self.barManager.top)
        self.addEdgeAreaLeft(self.barManager.left)
        self.addEdgeAreaBottom(self.barManager.bottom)
        self.addEdgeAreaRight(self.barManager.right)
        
        self.barManager.top.layoutItems()
        self.barManager.bottom.layoutItems()
        self.barManager.left.layoutItems()
        self.barManager.right.layoutItems()
    }
}
