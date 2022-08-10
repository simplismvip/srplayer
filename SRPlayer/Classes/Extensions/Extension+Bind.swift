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
        guard let model = self.flowManager.model(SRPlayFlow.self) else {
            return
        }
        
        let sliderItem = self.barManager.bottom.sliderItem()
        let curTimeItem = self.barManager.bottom.buttonItem(.curTime)
        let tolTimeItem = self.barManager.bottom.buttonItem(.tolTime)
        
        model.observe(TimeInterval.self, "currentTime") { currentTime in
            sliderItem?.value = model.progress
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
    }
}
