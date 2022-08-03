//
//  SRPlayerNormalController.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//  Copyright © 2022 JunMing. All rights reserved.

import UIKit
import ZJMKit

public class SRPlayerNormalController: SRPlayerController {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        config()
        initEdgeItems()
        addEdgeSubViews()
        registerMsg()
        registerItemsEvent()
        kvoBind()
    }
    
    public func reset() {
//        processM.reset()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

/** Private Func */
extension SRPlayerNormalController {
    private func config() {
        let router = JMRouter()
        self.jmSetAssociatedMsgRouter(router: router)
        self.processM.jmSetAssociatedMsgRouter(router: router)
        
        let playP = SRPlayProcess()
        let urlP = SRPlayUrlProgress()
        let switchP = SRQualitySwitchProcess()
        self.processM.addProcess(playP)
        self.processM.addProcess(urlP)
        self.processM.addProcess(switchP)
    }
}
