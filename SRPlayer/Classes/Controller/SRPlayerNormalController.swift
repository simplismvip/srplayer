//
//  SRPlayerNormalController.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//  Copyright © 2022 JunMing. All rights reserved.

import UIKit
import ZJMKit

public class SRPlayerNormalController: SRPlayerController {
    let videoType: VideoType
    public init(_ type: VideoType) {
        self.videoType = type
        super.init(frame: .zero)
        configFlow()
        initEdgeItems()
        addEdgeSubViews()
        registerMsgEvent()
        registerItemEvent()
        kvoBind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/** Private Func */
extension SRPlayerNormalController {
    public func configFlow() {
        let router = JMRouter()
        self.jmSetAssociatedMsgRouter(router: router)
        self.flowManager.jmSetAssociatedMsgRouter(router: router)
        
        let playP = SRPlayFlow()
        let urlP = SRSeekFlow()
        let switchP = SRQualityFlow()
        let moreFlow = SRMoreAreaFlow()
        self.flowManager.addFlow(playP)
        self.flowManager.addFlow(urlP)
        self.flowManager.addFlow(switchP)
        self.flowManager.addFlow(moreFlow)
    }
    
    public func reset() {
//        processM.reset()
    }
}
