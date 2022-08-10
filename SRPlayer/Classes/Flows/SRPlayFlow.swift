//
//  SRPlayFlow.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

class SRPlayFlow: NSObject {
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

extension SRPlayFlow: SRFlow {
    func configFlow() {
        /// 准备初始化
        jmReciverMsg(msgName: kMsgNamePlayStartSetup) { [weak self] builder in
            if let build = builder as? PlayerBulider {
                SRLogger.debug("初始化播放器.....")
                self?.setupPlayer(build)
                self?.jmSendMsg(msgName: kMsgNameStartLoading, info: nil)
            }
            return nil
        }
        
        /// 准备播放
        jmReciverMsg(msgName: kMsgNamePrepareToPlay) { [weak self] _ in
            self?.model.isPrepareToPlay = true
            SRLogger.debug("准备播放.....")
            return nil
        }
        
        /// 开始播放
        jmReciverMsg(msgName: kMsgNameStartPlay) { [weak self] builder in
            guard let ijkPlayer = self?.player else {
                return nil
            }
            
            self?.jmSendMsg(msgName: kMsgNameEndLoading, info: nil)
            
            self?.model.isPlaying = ijkPlayer.isPlaying()
            self?.model.playableDuration = ijkPlayer.getPlayableDuration()
            self?.model.duration = ijkPlayer.getDuration()
            self?.model.currentTime = ijkPlayer.getCurrentPlaybackTime()
            self?.model.playbackVolume = ijkPlayer.getVolume()
            self?.model.cacheDuration = ijkPlayer.getVideoCacheDuration()
            self?.model.playState = ijkPlayer.getPlayState()
            self?.model.loadState = ijkPlayer.getLoadState()
            self?.model.scalingMode = ijkPlayer.getScalingMode()
            self?.model.naturalSize = ijkPlayer.getNaturalSize()
            self?.model.playbackVolume = ijkPlayer.getVolume()
            self?.model.playbackRate = ijkPlayer.getPlaybackRate()
            
            SRLogger.debug("开始播放.....")
            return nil
        }
        
        /// 播放
        jmReciverMsg(msgName: kMsgNameActionPlay) { [unowned self] _ in
            if let playView = self.player?.view, let containerView = self.containerView {
                SRLogger.debug("重新添加播放器到容器并设置播放器frame.....")
                containerView.addSubview(playView)
                playView.translatesAutoresizingMaskIntoConstraints = true
                playView.frame = containerView.bounds;
            }
            return nil
        }
        
        /// 暂停播放
        jmReciverMsg(msgName: kMsgNamePauseOrRePlay) { [weak self] _ in
            if let isPlaying = self?.player?.isPlaying(), isPlaying {
                self?.player?.pause()
                self?.model.isPlaying = false
            } else {
                self?.model.isPlaying = true
                self?.player?.startPlay()
            }
            return nil
        }
        
        /// 快进快退
        jmReciverMsg(msgName: kMsgNameActionSeekTo) { [weak self] seekValue in
            if let offset = seekValue as? CGFloat {
                self?.player?.seekto(offset)
            }
            return nil
        }
        
        /// 静音
        jmReciverMsg(msgName: kMsgNameActionMute) { [weak self] _ in
            self?.player?.setMute()
            return nil
        }
        
        /// 更改播放速率
        jmReciverMsg(msgName: kMsgNameChangePlaybackRate) { [weak self] pRate in
            if let rate = pRate as? PlaybackRate {
                self?.player?.setPlayRate(rate)
                self?.model.playbackRate = rate
            }
            return nil
        }
        
        /// 更改放缩比例
        jmReciverMsg(msgName: kMsgNameChangeScalingMode) { [weak self] scamode in
            if let smode = scamode as? ScalingMode {
                self?.player?.setScraModel(smode)
                self?.model.scalingMode = smode
            }
            return nil
        }
        
        /// 截图
        jmReciverMsg(msgName: kMsgNameShotScreen) { [weak self] _ in
            self?.model.thumbImage = self?.player?.getThumbnailImageAtCurrentTime()
            self?.jmSendMsg(msgName: kMsgNameScreenShotDone, info: nil)
            return nil
        }
        
        /// 播放器播放进度更新
        jmReciverMsg(msgName: kMsgNamePlaybackTimeUpdate) { [weak self] _ in
            guard let ijkPlayer = self?.player, let model = self?.model else {
                return nil
            }

            if model.currentTime != ijkPlayer.getCurrentPlaybackTime() {
                model.currentTime = ijkPlayer.getCurrentPlaybackTime()
                SRLogger.debug("当前时长：\(Int(model.currentTime).format)")
                SRLogger.debug("总时长：\(Int(model.duration).format)")
                SRLogger.debug("播放进度：\(model.progress)")
            }
            
            return nil
        }
        
        /// 切换清晰度
        jmReciverMsg(msgName: kMsgNameSwitchQuality) { [weak self] mute in
//            self?.model.player.
            return nil
        }
    }
}
