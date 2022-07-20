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
        setup()
    }
    
    public func smallPlayFrameReset() {
        let video = UIView()
        self.addPlayer(video)
    }
    
    public func reset() {
        processM.reset()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRPlayerNormalController {
    func registerMsg() {
        /// 开始播放
        jmReciverMsg(msgName: kMsgNameAddPlayerView) { [weak self] playView in
            if let view = playView as? UIView {
                self?.addPlayer(view)
                SRLogger.debug("开始播放.....")
            }
            
            return nil
        }
        
        /// 准备开始播放
        jmReciverMsg(msgName: kMsgNamePrepareToPlay) { _ in
            SRLogger.debug("准备播放.....")
            return nil
        }
        
        /// 开始播放
        jmReciverMsg(msgName: kMsgNamePrepareToPlay) { _ in
            SRLogger.debug("开始播放.....")
            return nil
        }
        
        /// 播放器进度更新
        jmReciverMsg(msgName: kMsgNamePlaybackTimeUpdate) { _ in
            
            return nil
        }
        
        /// 快进快退失败
        jmReciverMsg(msgName: kMsgNamePlayerSeekFailed) { _ in
            
            return nil
        }
        
        /// 快进快退
        jmReciverMsg(msgName: kMsgNamePlayerSeeking) { _ in
            
            return nil
        }
        
        /// 快进快退完成
        jmReciverMsg(msgName: kMsgNamePlayerSeekEnded) { _ in
            
            return nil
        }
        
        /// 静音
        jmReciverMsg(msgName: kMsgNameActionMute) { _ in
            
            return nil
        }
        
        /// 更改播放速率
        jmReciverMsg(msgName: kMsgNameChangePlaybackRate) { _ in
            
            return nil
        }
        
        /// 更改放缩比例
        jmReciverMsg(msgName: kMsgNameChangeScalingMode) { _ in
            
            return nil
        }
        
        /// 截图
        jmReciverMsg(msgName: kMsgNameShotScreen) { _ in
            
            return nil
        }
    }
}

/** Private Func */
extension SRPlayerNormalController {
    private func setup() {
        config()
        initEdgeItems()
        addEdgeSubViews()
        registerMsg()
    }
    
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
