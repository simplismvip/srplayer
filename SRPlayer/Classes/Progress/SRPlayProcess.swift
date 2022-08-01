//
//  SRPlayProcess.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit
import IJKMediaFrameworkWithSSL

class SRPlayProcess: NSObject {
    private var disposes = Set<RSObserver>()
    internal var model: SRPlayModel
    private var player: SRIjkPlayer?
    var containerView: UIView?
    
    override init() {
        self.model = SRPlayModel()
        super.init()
    }
    
    private func setupPlayer(_ build: PlayerBulider) {
        stopPlayer()
        player = SRIjkPlayer(build)
        player?.associatedRouter(self.msgRouter)
        // 添加视频view到播放器
        jmSendMsg(msgName: kMsgNameAddPlayerView, info: player?.view)
        containerView = player?.view.superview
    }
    
    private func stopPlayer() {
        player?.stopPlayer()
        player = nil
    }
    
    deinit {
        disposes.forEach { $0.deallocObserver() }
        disposes.removeAll()
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension SRPlayProcess: SRProgress {
    func configProcess() {
        /// 准备初始化
        jmReciverMsg(msgName: kMsgNamePlayStartSetup) { [weak self] builder in
            if let build = builder as? PlayerBulider {
                self?.setupPlayer(build)
                self?.jmSendMsg(msgName: kMsgNameStartLoading, info: nil)
            }
            return nil
        }
        
        /// 准备播放
        jmReciverMsg(msgName: kMsgNamePrepareToPlay) { [weak self] _ in
            self?.model.isPrepareToPlay = true
            return nil
        }
        
        /// 开始播放
        jmReciverMsg(msgName: kMsgNameStartPlay) { [weak self] builder in
            self?.jmSendMsg(msgName: kMsgNameEndLoading, info: nil)
            self?.model.isPlaying = true
            
            if let ijkPlayer = self?.player {
                self?.model.isMute = ijkPlayer.isMute
                self?.model.duration = ijkPlayer.duration
                
                self?.model.playState = ijkPlayer.playState
                self?.model.loadState = ijkPlayer.loadState
                self?.model.scalingMode = ijkPlayer.scalingMode
                
                self?.model.naturalSize = ijkPlayer.naturalSize
                self?.model.playbackRate = ijkPlayer.playbackRate
            }
            return nil
        }
        
        /// 播放
        jmReciverMsg(msgName: kMsgNameActionPlay) { [unowned self] _ in
            if let playView = self.player?.view, let containerView = self.containerView {
                containerView.addSubview(playView)
                playView.translatesAutoresizingMaskIntoConstraints = true
                playView.frame = containerView.bounds;
            }
        
//            if self.model.isPlaying {
//                self.play()
//            }
            
            return nil
        }
        
        /// 停止播放
        jmReciverMsg(msgName: kMsgNameStopPlay) { [weak self] _ in
            self?.model.isPlaying = false
            return nil
        }
        
        /// 意外终止播放
        jmReciverMsg(msgName: kMsgNameFinishedPlay) { _ in
            
            return nil
        }
        
        /// 暂停播放
        jmReciverMsg(msgName: kMsgNamePauseOrRePlay) { [weak self] _ in
            if let isPlaying = self?.player?.isPlaying, isPlaying {
                self?.player?.pause()
            } else {
                self?.player?.startPlay()
            }
            return nil
        }
        
        /// 快进快退
        jmReciverMsg(msgName: kMsgNameActionSeekTo) { _ in
            
            return nil
        }
        
        /// 切换清晰度
        jmReciverMsg(msgName: kMsgNameSwitchQuality) { [weak self] mute in
//            self?.model.player.
            return nil
        }
        
        /// 静音
        jmReciverMsg(msgName: kMsgNameActionMute) { [weak self] _ in
            self?.player?.setMute()
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
        
        /// 添加播放器view到视图
        jmReciverMsg(msgName: kMsgNameAddPlayerView) { _ in
            
            return nil
        }
        
        /// 播放器播放进度更新
        jmReciverMsg(msgName: kMsgNamePlaybackTimeUpdate) { [weak self] _ in
            if let ijkPlayer = self?.player {
                self?.model.currentTime = ijkPlayer.currentTime
                self?.model.cacheDuration = ijkPlayer.videoCacheDuration
                SRLogger.debug("当前时长：\(Int(ijkPlayer.currentTime).format)")
                SRLogger.debug("总时长：\(Int(ijkPlayer.duration).format)")
                SRLogger.debug("播放进度：\(self?.model.progress ?? 0.0)")
                // SRLogger.debug("视频缓存时长：\(Int(ijkPlayer.videoCacheDuration).format)")
                // SRLogger.debug("当前速率：\(ijkPlayer.playbackRate)")
            }
            return nil
        }
        
        /// 快进、快退
        jmReciverMsg(msgName: kMsgNamePlayerSeeking) { _ in
            
            return nil
        }
        
        /// 快进、快退结束
        jmReciverMsg(msgName: kMsgNamePlayerSeekEnded) { _ in
            
            return nil
        }
    }
}
