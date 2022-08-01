//
//  SRPlayerNormalController.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//  Copyright © 2022 JunMing. All rights reserved.

import UIKit
import ZJMKit

public class SRPlayerNormalController: SRPlayerController {
    let processM: SRProgressManager
    let barManager: SRBarManager
    
    public override init(frame: CGRect) {
        self.barManager = SRBarManager()
        self.processM = SRProgressManager()
        super.init(frame: frame)
        
        config()
        initEdgeItems()
        addEdgeSubViews()
        registerMsg()
        addNotioObserve()
        registerEvent()
    }
    
    public func reset() {
        processM.reset()
    }
    
    private func addNotioObserve() {
        NotificationCenter.default.jm.addObserver(target: self, name: NSNotification.Name.UIApplicationWillChangeStatusBarOrientation.rawValue) { (notify) in
            SRLogger.debug("UIApplicationWillChangeStatusBarOrientation")
        }
        
        NotificationCenter.default.jm.addObserver(target: self, name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation.rawValue) { [weak self] (notify) in
            let orientation = UIApplication.shared.statusBarOrientation
            switch (orientation) {
            case .portrait:
                SRLogger.debug("half")
                self?.remakePlayer(.half)
                self?.barManager.setScreenType(.half)
            case .landscapeLeft, .landscapeRight:
                SRLogger.debug("full")
                self?.remakePlayer(.full)
                self?.barManager.setScreenType(.full)
            default:
                SRLogger.debug("statusBarOrientation")
            }
        }
    }
    
    private func remakePlayer(_ type: ScreenType) {
        guard let sView = superview else { return }
        if type == .full {
            self.snp.remakeConstraints { make in
                make.edges.equalTo(sView)
            }
        } else if type == .half {
            self.snp.remakeConstraints { make in
                make.left.width.equalTo(sView)
                make.height.equalTo(min(sView.jmWidth, sView.jmHeight) * 0.56)
                if #available(iOS 11.0, *) {
                    make.top.equalTo(sView.safeAreaLayoutGuide.snp.top)
                } else {
                    make.top.equalTo(sView.snp.top)
                }
            }
        }
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
        self.processM.jmSetAssociatedMsgRouter(router: router)
        
        let playP = SRPlayProcess()
        let urlP = SRPlayUrlProgress()
        let switchP = SRQualitySwitchProcess()
        self.processM.addProcess(playP)
        self.processM.addProcess(urlP)
        self.processM.addProcess(switchP)
    }
}
