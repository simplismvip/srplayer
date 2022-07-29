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
    var model: SRPlayModel
    var containerView: UIView?
    override init() {
        self.model = SRPlayModel()
        super.init()
    }
    
    private func setupPlayer(url: URL) {
        stopPlayer()
        // IJKFFMonitor
        let player = IJKFFMoviePlayerController(contentURL: url, with: Options.options())
        player?.view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        player?.scalingMode = .aspectFit
        player?.allowsMediaAirPlay = true
        player?.shouldAutoplay = true
        player?.prepareToPlay()
        installObserver()
        model.setModel(player)
        jmSendMsg(msgName: kMsgNameAddPlayerView, info: player?.view)
        containerView = player?.view.superview
    }
    
    private func stopPlayer() {
        if (model.player != nil) {
            removeObserver()
            stop()
            shutdown()
            model.player?.view.removeFromSuperview()
            model.player = nil
            SRLogger.debug("🤬🤬🤬🤬🤬 - 释放播放器")
        }
    }
    
    private func addObserve(select: Selector, name: Noti) {
        NotificationCenter.default.addObserver(self, selector: select, name: name.name, object: model.player)
    }
    
    private func remove(_ name: Noti) {
        NotificationCenter.default.removeObserver(self, name: name.name, object: model.player)
    }
    
    private func removeObserver() {
        [Noti.change, Noti.finish, Noti.isPrepared, Noti.stateChange].forEach {
            remove($0)
        }
    }
    
    private func addKVO() {
        
//        model.player?.observe(NSTimeInterval.self, "currentPlaybackTime") { [weak self] timeback in
//            
//        }.add(&disposes)
    }
    
    private func installObserver() {
        addObserve(select: #selector(self.loadStateDidChange), name: .change)
        addObserve(select: #selector(self.moviePlayBackDidFinish), name: .finish)
        addObserve(select: #selector(self.mediaIsPreparedToPlayDidChange), name: .isPrepared)
        addObserve(select: #selector(self.moviePlayBackStateDidChange), name: .stateChange)
    }
    
    enum Noti {
        case change
        case finish
        case isPrepared
        case stateChange
        var name: NSNotification.Name {
            switch self {
            case .change:
                return NSNotification.Name.IJKMPMoviePlayerLoadStateDidChange
            case .finish:
                return NSNotification.Name.IJKMPMoviePlayerPlaybackDidFinish
            case .isPrepared:
                return NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange
            case .stateChange:
                return NSNotification.Name.IJKMPMoviePlayerPlaybackStateDidChange
            }
        }
    }
    
    deinit {
        disposes.forEach { $0.deallocObserver() }
        disposes.removeAll()
        removeObserver()
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension SRPlayProcess: SRProgress {
    func configProcess() {
        /// 开始播放
        jmReciverMsg(msgName: kMsgNameStartPlay) { [weak self] builder in
            if let build = builder as? PlayerBulider {
                self?.setupPlayer(url: build.url)
                SRLogger.debug("Url:\(build.url)")
            }
            return nil
        }
        
        /// 播放
        jmReciverMsg(msgName: kMsgNameActionPlay) { [unowned self] _ in
            if let playView = self.model.playView, let containerView = self.containerView {
                containerView.addSubview(playView)
                playView.translatesAutoresizingMaskIntoConstraints = true
                playView.frame = containerView.bounds;
            }
        
            if self.model.isPlaying {
                self.play()
            }
            
            return nil
        }
        
        /// 停止播放
        jmReciverMsg(msgName: kMsgNameStopPlay) { _ in
            
            return nil
        }
        
        /// 暂停播放
        jmReciverMsg(msgName: kMsgNamePauseOrRePlay) { [weak self] _ in
            if let isPlaying = self?.model.player?.isPlaying(), isPlaying {
                self?.pause()
            } else {
                self?.play()
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
            self?.setMute()
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

extension SRPlayProcess {
    @objc func loadStateDidChange(_ notification: Notification) {
        if let loadState = model.player?.loadState {
            if loadState.contains(.playthroughOK) {
                SRLogger.debug("loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: \(loadState)\n")
            } else if loadState.contains(.stalled) {
                SRLogger.debug("loadStateDidChange: IJKMPMovieLoadStateStalled: \(loadState)\n")
            } else {
                SRLogger.debug("loadStateDidChange: ???: \(loadState)\n")
            }
        }
    }
    
    @objc func moviePlayBackDidFinish(_ notification: Notification) {
        let reason = notification.userInfo?[IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as! Int
        switch reason {
        case FinishReason.ended.ijk:
            SRLogger.debug("playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: \(reason)\n")
        case FinishReason.exited.ijk:
            SRLogger.debug("playbackStateDidChange: IJKMPMovieFinishReasonUserExited: \(reason)\n")
        case FinishReason.error.ijk:
            SRLogger.debug("playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: \(reason)\n")
        default:
            SRLogger.debug("playbackPlayBackDidFinish: ???: \(reason)\n")
        }
    }
    
    @objc func mediaIsPreparedToPlayDidChange(notification: Notification) {
        SRLogger.debug("mediaIsPreparedToPlayDidChange\n")
    }
    
    @objc func moviePlayBackStateDidChange(_ notification: Notification) {
        guard model.player != nil else {
            return
        }
        switch model.player!.playbackState {
        case .stopped:
            SRLogger.debug("IJKMPMoviePlayBackStateDidChange \(String(describing: model.player?.playbackState)): stoped")
            break
        case .playing:
            SRLogger.debug("IJKMPMoviePlayBackStateDidChange \(String(describing: model.player?.playbackState)): playing")
            break
        case .paused:
            SRLogger.debug("IJKMPMoviePlayBackStateDidChange \(String(describing: model.player?.playbackState)): paused")
            break
        case .interrupted:
            SRLogger.debug("IJKMPMoviePlayBackStateDidChange \(String(describing: model.player?.playbackState)): interrupted")
            break
        case .seekingForward, .seekingBackward:
            SRLogger.debug("IJKMPMoviePlayBackStateDidChange \(String(describing: model.player?.playbackState)): seeking")
            break
        }
    }
}

/// Public Func
extension SRPlayProcess {
    public func thumbnailImageAtCurrentTime() -> UIImage? {
        return model.player?.thumbnailImageAtCurrentTime()
    }
    
    public func setAllowsMediaAirPlay(_ airplay: Bool) {
        model.player?.allowsMediaAirPlay = airplay
    }
    
    public func setDanmakuMediaAirPlay(_ airplay: Bool) {
        model.player?.isDanmakuMediaAirPlay = airplay
    }
    
    public func setPlayerRate(_ playbackRate: Float) {
        model.player?.playbackRate = playbackRate
    }
    
    public func setPlayerVolume(_ playbackVolume: Float) {
        model.player?.playbackVolume = playbackVolume
    }
}

// 播放器相关
extension SRPlayProcess {
    private func prepareToPlay() {
        model.player?.prepareToPlay()
    }
    
    private func play() {
        model.player?.play()
    }
    
    private func pause() {
        model.player?.pause()
    }
    
    private func stop() {
        model.player?.stop()
    }
    
    private func setMute() {
        model.player?.playbackVolume = 0
    }
    
    private func shutdown() {
        model.player?.shutdown()
    }
    
    private func setPauseInBackground(_ pause: Bool) {
        model.player?.setPauseInBackground(pause)
    }
}
