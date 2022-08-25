//
//  Extension+Observer.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/6.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

// KVO 绑定
extension SRPlayerNormalController {
    func kvoBind() {
        guard let model = self.flowManager.model(SRPlayFlow.self) else {
            return
        }
        
        let sliderItem = self.barManager.bottom.sliderItem()
        let curTimeItem = self.barManager.bottom.buttonItem(.curTime)
        let tolTimeItem = self.barManager.bottom.buttonItem(.tolTime)
        
        model.observe(TimeInterval.self, "currentTime") { currentTime in
            if !model.isSeeking { // seek状态屏蔽进度
                sliderItem?.value = model.progress
            }
            
            if let currTime = currentTime {
                curTimeItem?.title = Int(currTime).format
                tolTimeItem?.title = Int(model.duration).format
            }
        }.add(&disposes)
        
        let playItem = self.barManager.bottom.buttonItem(.play)
        model.observe(Bool.self, "isPlaying") { isPlaying in
            if let play = isPlaying {
                playItem?.image = play ? "sr_pause" : "sr_play"
            }
        }.add(&disposes)
        
        let rateItem = self.barManager.bottom.buttonItem(.playRate)
        model.observe(String.self, "playRateStr") { pRate in
            rateItem?.title = pRate
        }.add(&disposes)
        
        let scaleItem = self.barManager.top.buttonItem(.scale)
        model.observe(String.self, "scaleImage") { imagename in
            scaleItem?.image = imagename
        }.add(&disposes)
        
        model.observe(String.self, "loadingStatue") { [weak self] _ in
            let current = NetSpeed.share.currNetSpeed(.all)
            if model.loadState == .stateStalled {
                self?.view.floatView.show(.netSpeed(current))
            } else {
                self?.view.floatView.hide(.netSpeed(current))
            }
        }.add(&disposes)
        
        let titleItem = self.barManager.top.titleItem()
        model.observe(String.self, "videoTitle") { videoTitle in
            titleItem?.title = videoTitle
        }.add(&disposes)
    }
}
