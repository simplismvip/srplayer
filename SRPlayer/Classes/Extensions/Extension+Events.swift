//
//  Extension+Events.swift
//  SRPlayer
//
//  Created by jh on 2022/7/29.
//

import UIKit
import ZJMKit

extension SRPlayerNormalController {
    func registerEvent() {
        jmRegisterEvent(eventName: kEventNameFullScrennAction, block: { [weak self] info in
            if self?.barManager.top.screenType == .half {
                UIDevice.setNewOrientation(.landscapeLeft)
            } else if self?.barManager.top.screenType == .full {
                UIDevice.setNewOrientation(.portrait)
            }
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNameBackAction, block: { [weak self] info in
            if self?.barManager.top.screenType == .half {
                
            } else if self?.barManager.top.screenType == .full {
                
            }
        }, next: false)
    }
}
