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
    func registerItemEvent() {
        jmRegisterEvent(eventName: kEventNameFullScrennAction, block: { [weak self] _ in
            let fullScrenn = self?.barManager.bottom.buttonItem(.fullScrenn)
            if self?.barManager.top.screenType == .half {
                UIDevice.setNewOrientation(.landscapeLeft)
                fullScrenn?.image = "sr_halfscreen"
            } else if self?.barManager.top.screenType == .full {
                UIDevice.setNewOrientation(.portrait)
                fullScrenn?.image = "sr_fullscreen"
            }
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNameBackAction, block: { [weak self] _ in
            let fullScrenn = self?.barManager.bottom.buttonItem(.fullScrenn)
            if self?.barManager.top.screenType == .half {
                fullScrenn?.image = "sr_halfscreen"
                self?.jmSendMsg(msgName: kMsgNameStopPlaying, info: nil)
                self?.jmRouterEvent(eventName: kEventNamePopController, info: nil)
            } else if self?.barManager.top.screenType == .full {
                UIDevice.setNewOrientation(.portrait)
                fullScrenn?.image = "sr_fullscreen"
            }
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNamePlayAction, block: { [weak self] info in
            self?.jmSendMsg(msgName: kMsgNamePauseOrRePlay, info: nil)
        }, next: false)
        
        // 更多
        jmRegisterEvent(eventName: kEventNameMoreAction, block: { [weak self] _ in
            if self?.barManager.top.screenType == .full {
                self?.showMoreArea(.more)
                self?.jmSendMsg(msgName: kMsgNameMoreAreaRequestData, info: MoreEdgeType.more as MsgObjc)
            } else {
                JMLogger.debug("半屏幕状态下点击更多")
            }
        }, next: false)
        
        // 更多选择
        jmRegisterEvent(eventName: kEventNameMoreChoiceAction, block: { [weak self] _ in
            JMLogger.debug("更多选择")
        }, next: false)
        
        // 播放速率
        jmRegisterEvent(eventName: kEventNamePlayRateAction, block: { [weak self] info in
            if self?.barManager.top.screenType == .full {
                self?.showMoreArea(.playrate)
                self?.jmSendMsg(msgName: kMsgNameMoreAreaRequestData, info: MoreEdgeType.playrate as MsgObjc)
            } else {
                JMLogger.debug("半屏幕状态下点击切换播放速率")
            }
        }, next: false)
        
        // 播放速率选择
        jmRegisterEvent(eventName: kEventNamePlayRateChoiceAction, block: { [weak self] moreItem in
            JMLogger.debug("播放速率选择")
        }, next: false)
        
        // 剧集
        jmRegisterEvent(eventName: kEventNamePlaySeriesAction, block: { [weak self] _ in
            if self?.barManager.top.screenType == .full {
                self?.showMoreArea(.series)
                self?.jmSendMsg(msgName: kMsgNameMoreAreaRequestData, info: MoreEdgeType.series as MsgObjc)
            } else {
                JMLogger.debug("半屏幕状态下点击剧集")
            }
        }, next: false)
        
        // 剧集选择
        jmRegisterEvent(eventName: kEventNamePlaySeriesChoiceAction, block: { [weak self] moreItem in
            JMLogger.debug("剧集选择")
        }, next: false)
        
        // 清晰度
        jmRegisterEvent(eventName: kEventNamePlayResolveAction, block: { [weak self] moreItem in
            if self?.barManager.top.screenType == .full {
                self?.showMoreArea(.resolve)
                self?.jmSendMsg(msgName: kMsgNameMoreAreaRequestData, info: MoreEdgeType.resolve as MsgObjc)
            } else {
                JMLogger.debug("半屏幕状态下点击清晰度")
            }
        }, next: false)
        
        // 清晰度选择
        jmRegisterEvent(eventName: kEventNamePlayResolveChoiceAction, block: { [weak self] moreItem in
            JMLogger.debug("清晰度选择")
        }, next: false)
  
        // 分享
        jmRegisterEvent(eventName: kEventNameShareAction, block: { [weak self] info in
            if self?.barManager.top.screenType == .full {
                self?.showMoreArea(.share)
                self?.jmSendMsg(msgName: kMsgNameMoreAreaRequestData, info: MoreEdgeType.share as MsgObjc)
            } else {
                JMLogger.debug("半屏幕状态下点击分享")
            }
        }, next: false)
        
        // 分享选择
        jmRegisterEvent(eventName: kEventNameShareChoiceAction, block: { [weak self] info in
            JMLogger.debug("分享选择")
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNameNextAction, block: { [weak self] info in
            JMLogger.debug("播放下一个")
        }, next: false)
        
        // 截屏
        jmRegisterEvent(eventName: kEventNameScreenShotAction, block: { [weak self] info in
            self?.jmSendMsg(msgName: kMsgNameShotScreen, info: nil)
        }, next: false)
        
        // 截取短视频
        jmRegisterEvent(eventName: kEventNameRecordingAction, block: { [weak self] info in
            JMLogger.debug("录像")
        }, next: false)
        
        // 视频缩放模式
        jmRegisterEvent(eventName: kEventNameScaleModeAction, block: { [weak self] info in
            if let model = self?.flowManager.model(SRPlayFlow.self) {
                if model.scalingMode == .aspectFit {
                    self?.jmSendMsg(msgName: kMsgNameChangeScalingMode, info: ScalingMode.aspectFill as MsgObjc)
                } else {
                    self?.jmSendMsg(msgName: kMsgNameChangeScalingMode, info: ScalingMode.aspectFit as MsgObjc)
                }
            }
        }, next: false)
        
        // 锁定、解锁
        jmRegisterEvent(eventName: kEventNameLockScreenAction, block: { [weak self] _ in
            if let lock = self?.barManager.left.buttonItem(.lockScreen) {
                lock.isLockScreen.toggle()
                lock.image = lock.isLockScreen ? "sr_lock" : "sr_unlock"
                self?.view.edgeAreaView.showUnit(units: [.right, .top, .bottom], visible: !lock.isLockScreen)
                self?.view.playerView.enableEvents([.longPress, .doubleClick, .pan], enabled: !lock.isLockScreen)
            }
        }, next: false)
        
        // Seek To
        jmRegisterEvent(eventName: kEventNameActionSeekToPlayTime, block: { [weak self] seekTo in
            if let offset = seekTo {
                self?.jmSendMsg(msgName: kMsgNameActionSeekTo, info: offset as MsgObjc)
            }
        }, next: false)
    }
}

extension SRPlayerNormalController {
    func registerMsgEvent() {
        /// 开始播放
        jmReciverMsg(msgName: kMsgNameAddPlayerView) { [weak self] playView in
            if let view = playView as? UIView {
                self?.addSubview(view, unit: .player)
                self?.view.bkgView.startPlay()
                JMLogger.debug("添加播放器到视图.....")
            }
            return nil
        }
        
        /// 准备开始播放
        jmReciverMsg(msgName: kMsgNameStartLoading) { [weak self] _ in
            JMLogger.debug("准备播放.....")
            self?.view.floatView.show(.loading)
            return nil
        }
        
        /// 开始播放
        jmReciverMsg(msgName: kMsgNamePrepareToPlay) { [weak self] _ in
            JMLogger.debug("开始播放.....")
            self?.view.floatView.hide(.loading)
            return nil
        }
        
        /// 停止播放
        jmReciverMsg(msgName: kMsgNamePausePlayEnding) { [weak self] _ in
            self?.view.bkgView.endPlay()
            return nil
        }
        
        /// 播放错误
        jmReciverMsg(msgName: kMsgNamePlayerUnknowError) { _ in
            SRToast.toast("发生未知错误")
            return nil
        }
        
        /// 截图完成，展示到视图上
        jmReciverMsg(msgName: kMsgNameScreenShotDone) { [weak self] _ in
            if let thumbImage = self?.flowManager.model(SRPlayFlow.self)?.thumbImage,
               let screenShot = self?.barManager.right.buttonItem(.screenShot),
               let v = self?.barManager.right.findView(screenShot),
               let point = self?.barManager.right.convert(v.frame.origin, to: self?.view.floatView) {
                let screen = ToastType.screenShot(point, thumbImage)
                self?.view.floatView.show(screen)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.view.floatView.hide(.screenShot(CGPoint.zero, UIImage()))
                }
            } else {
                SRToast.toast("截图失败！")
            }
            return nil
        }
        
        /// MoreArea 刷新数据
        jmReciverMsg(msgName: kMsgNameMoreAreaReloadData) { [weak self] _ in
            if let model = self?.flowManager.model(SRMoreAreaFlow.self) {
                self?.view.moreAreaView.relodata(model.items)
            }
            return nil
        }
        
        /// 卡顿展示loading和网速
        jmReciverMsg(msgName: kMsgNameNetBreakingUpStatus) { [weak self] _ in
            let current = NetSpeed.share.currNetSpeed(.all)
            self?.view.floatView.update(.netSpeed(current))
            JMLogger.debug("卡顿展示loading和网速\(current)")
            return nil
        }
        
        /// 展示是否跳到之前播放的地方
        jmReciverMsg(msgName: kMsgNameShowSeekToPlayTime) { [weak self] videos in
            if let v = videos as? Video {
                self?.view.floatView.show(.seekAction(0.0, ""))
                self?.view.floatView.update(.seekAction(Float(v.currTime), "上次播放到\(Int(v.currTime).format)"))
                JMLogger.debug("展示是否Seek进度")
            }
            return nil
        }
    }
}
