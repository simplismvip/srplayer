//
//  Extension+Events.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/29.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

extension SRPlayerNormalController {
    func registerItemsEvent() {
        jmRegisterEvent(eventName: kEventNameFullScrennAction, block: { [weak self] _ in
            let fullScrenn = self?.barManager.bottom.buttonItem(.fullScrenn)
            if self?.barManager.top.screenType == .half {
                UIDevice.setNewOrientation(.landscapeLeft)
                fullScrenn?.image = "sr_capture"
            } else if self?.barManager.top.screenType == .full {
                UIDevice.setNewOrientation(.portrait)
                fullScrenn?.image = "sr_fullscreen"
            }
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNameBackAction, block: { [weak self] _ in
            let fullScrenn = self?.barManager.bottom.buttonItem(.fullScrenn)
            if self?.barManager.top.screenType == .half {
                fullScrenn?.image = "sr_capture"
                self?.jmRouterEvent(eventName: kEventNamePopController, info: nil)
            } else if self?.barManager.top.screenType == .full {
                UIDevice.setNewOrientation(.portrait)
                fullScrenn?.image = "sr_fullscreen"
            }
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNamePlayAction, block: { [weak self] info in
            self?.jmSendMsg(msgName: kMsgNamePauseOrRePlay, info: nil)
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNameMoreAction, block: { [weak self] _ in
            SRLogger.debug("更多")
            self?.view.moreAreaView.visibleMore(true, animation: true)
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNamePlayRateAction, block: { [weak self] info in
            SRLogger.debug("切换播放速率")
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNameShareAction, block: { [weak self] info in
            SRLogger.debug("分享")
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNameNextAction, block: { [weak self] info in
            SRLogger.debug("播放下一个")
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNameScreenShotAction, block: { [weak self] info in
            SRLogger.debug("截屏")
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNameRecordingAction, block: { [weak self] info in
            SRLogger.debug("录像")
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNameLockScreenAction, block: { [weak self] _ in
            if let lock = self?.barManager.left.buttonItem(.lockScreen) {
                lock.isLockScreen.toggle()
                lock.image = lock.isLockScreen ? "sr_lock" : "sr_unlock"
                self?.view.edgeAreaView.showUnit(units: [.right, .top, .bottom], visible: !lock.isLockScreen)
                self?.view.playerView.enableEvents([.longPress, .doubleClick, .pan], enabled: !lock.isLockScreen)
            }
        }, next: false)
    }
    
    func registerMsg() {
        /// 开始播放
        jmReciverMsg(msgName: kMsgNameAddPlayerView) { [weak self] playView in
            if let view = playView as? UIView {
                self?.addSubview(view, unit: .player)
                self?.view.bkgView.startPlay()
                SRLogger.debug("添加播放器到视图.....")
            }
            return nil
        }
        
        /// 准备开始播放
        jmReciverMsg(msgName: kMsgNameStartLoading) { _ in
            SRLogger.debug("准备播放.....")
            return nil
        }
        
        /// 开始播放
        jmReciverMsg(msgName: kMsgNamePrepareToPlay) { _ in
            SRLogger.debug("开始播放.....")
            return nil
        }
        
        /// 停止播放
        jmReciverMsg(msgName: kMsgNameStopPlay) { [weak self] _ in
            self?.view.bkgView.endPlay()
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
