//
//  Extension+Observer.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/6.
//

import UIKit

// KVO 绑定
extension SRPlayerNormalController {
    func kvoBind() {
        let model = self.processM.model(SRPlayProcess.self)
        let sliderItem = self.barManager.bottom.sliderItem()
        let curTimeItem = self.barManager.bottom.buttonItem(.curTime)
        let tolTimeItem = self.barManager.bottom.buttonItem(.tolTime)
        
        model?.observe(TimeInterval.self, "currentTime") { currentTime in
            if let progress = model?.progress,
                let duration = model?.duration,
                let currTime = currentTime {
                sliderItem?.value = progress
                curTimeItem?.title = Int(currTime).format
                tolTimeItem?.title = Int(duration).format
            }
        }.add(&disposes)
        
        let playItem = self.barManager.bottom.buttonItem(.play)
        model?.observe(Bool.self, "isPlaying") { isPlaying in
            if let play = isPlaying {
                playItem?.image = play ? "sr_pause" : "sr_play"
            }
        }.add(&disposes)
        
        let rateItem = self.barManager.bottom.buttonItem(.playRate)
        model?.observe(String.self, "playRateStr") { pRate in
            rateItem?.title = pRate
        }.add(&disposes)
    }
}
