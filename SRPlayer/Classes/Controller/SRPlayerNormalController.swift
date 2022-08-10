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
}

/** Private Func */
extension SRPlayerNormalController {
    private func config() {
        let router = JMRouter()
        self.jmSetAssociatedMsgRouter(router: router)
        self.flowManager.jmSetAssociatedMsgRouter(router: router)
        
        let playP = SRPlayFlow()
        let urlP = SRPlayUrlFlow()
        let switchP = SRQualityFlow()
        let moreFlow = SRMoreAreaFlow()
        self.flowManager.addFlow(playP)
        self.flowManager.addFlow(urlP)
        self.flowManager.addFlow(switchP)
        self.flowManager.addFlow(moreFlow)
    }
}
