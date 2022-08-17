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
    
    private func refrashStatus() {
        guard let ijkPlayer = self.player else {
            return
        }
        model.isPlaying = ijkPlayer.isPlaying()
        model.playableDuration = ijkPlayer.getPlayableDuration()
        model.duration = ijkPlayer.getDuration()
        model.currentTime = ijkPlayer.getCurrentPlaybackTime()
        model.playbackVolume = ijkPlayer.getVolume()
        model.cacheDuration = ijkPlayer.getVideoCacheDuration()
        model.playState = ijkPlayer.getPlayState()
        model.loadState = ijkPlayer.getLoadState()
        model.scalingMode = ijkPlayer.getScalingMode()
        model.naturalSize = ijkPlayer.getNaturalSize()
        model.playbackVolume = ijkPlayer.getVolume()
        model.playbackRate = ijkPlayer.getPlaybackRate()
    }
    
    deinit {
        disposes.forEach { $0.deallocObserver() }
        disposes.removeAll()
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension SRPlayFlow: SRFlow {
    // 这个方法中注册被动接受ijkplayer播放器回调
    func registerObserver() {
        /// 准备播放
        jmReciverMsg(msgName: kMsgNamePrepareToPlay) { [weak self] _ in
            self?.model.isPrepareToPlay = true
            SRLogger.debug("准备播放.....")
            return nil
        }
        
        /// 开始播放
        jmReciverMsg(msgName: kMsgNameStartPlay) { [weak self] builder in
            self?.jmSendMsg(msgName: kMsgNameEndLoading, info: nil)
            self?.refrashStatus()
            SRLogger.debug("开始播放.....")
            return nil
        }
        
        /// 播放器播放进度更新
        jmReciverMsg(msgName: kMsgNamePlaybackTimeUpdate) { [weak self] _ in
            guard let ijkPlayer = self?.player, let model = self?.model else {
                return nil
            }

            if model.currentTime != ijkPlayer.getCurrentPlaybackTime() {
                model.currentTime = ijkPlayer.getCurrentPlaybackTime()
                SRLogger.debug("当前时长：\(Int(model.currentTime).format),总时长：\(Int(model.duration).format), 播放进度：\(model.progress)")
            }
            
            // 如果卡顿弹出提示框
            if model.loadState == .stateStalled {
                self?.jmSendMsg(msgName: kMsgNameNetBreakingUpStatus, info: nil)
            }
            
            return nil
        }
        
        /// 刷新播放器状态
        jmReciverMsg(msgName: kMsgNameRefreashPlayerStatus) { [weak self] builder in
            self?.refrashStatus()
            return nil
        }
    }
    
    // 主动调用注册消息
    func configFlow() {
        registerObserver()
        
        /// 准备初始化
        jmReciverMsg(msgName: kMsgNamePlayStartSetup) { [weak self] builder in
            if let build = builder as? PlayerBulider {
                SRLogger.debug("初始化播放器.....")
                self?.setupPlayer(build)
                self?.jmSendMsg(msgName: kMsgNameStartLoading, info: nil)
            }
            return nil
        }
        
        /// 暂停或者播放
        jmReciverMsg(msgName: kMsgNamePauseOrRePlay) { [weak self] _ in
            if let isPlaying = self?.player?.isPlaying(), isPlaying {
                self?.player?.pause()
            } else {
                self?.player?.startPlay()
            }
            return nil
        }
        
        /// 暂停播放
        jmReciverMsg(msgName: kMsgNamePausePlaying) { [weak self] _ in
            self?.player?.pause()
            return nil
        }
        
        /// 停止播放
        jmReciverMsg(msgName: kMsgNameStopPlaying) { [weak self] _ in
            self?.stopPlayer()
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
        
        /// 切换清晰度
        jmReciverMsg(msgName: kMsgNameSwitchQuality) { [weak self] mute in
//            self?.model.player.
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
    }
    
    public func willRemoveFlow() {
        
    }
    
    public func didRemoveFlow(){
        
    }
}
