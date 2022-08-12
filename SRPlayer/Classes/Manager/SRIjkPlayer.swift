//
//  SRIjkPlayer.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/31.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit
import IJKMediaFramework

class SRIjkPlayer: NSObject {
    /** 显示视频的视图 */
    let view: UIView
    /** 播放流类型 */
    var streamType: StreamType
    /** 播放器 */
    private var ijkPlayer: IJKFFMoviePlayerController
    /** kvo监听 */
    private var ijkKvo: IJKKVOController?
    /** 开启时间循环 */
    private var timer: Timer?
    
    init(_ build: PlayerBulider) {
        self.ijkPlayer = IJKFFMoviePlayerController(contentURL: build.video.videoUrl, with: Options.options())
        self.ijkPlayer.playbackRate = build.playRate.rawValue
        self.view = ijkPlayer.view
        self.streamType = build.stream
        super.init()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(gatCuttentTime), userInfo: nil, repeats: true)
        // self.ijkKvo = IJKKVOController(target: self)
        ijkPlayer.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        ijkPlayer.scalingMode = build.scaMode.transTo()
        ijkPlayer.allowsMediaAirPlay = build.mirror
        ijkPlayer.shouldAutoplay = build.autoPlay
        ijkPlayer.prepareToPlay()
        addPlayerObserver()
    }
    
    public func associatedRouter(_ router: JMRouter?) {
        guard let r = router else { return }
        jmSetAssociatedMsgRouter(router: r)
    }
    
    func stopPlayer() {
        timer?.invalidate()
        timer = nil
        stop()
        shutdown()
        ijkPlayer.view.removeFromSuperview()
        removePlayerObserver()
    }

    @objc private func gatCuttentTime() {
        if ijkPlayer.isPlaying() {
            jmSendMsg(msgName: kMsgNamePlaybackTimeUpdate, info: nil)
        }
    }
    
    deinit {
        SRLogger.debug("‼️‼️‼️‼️‼️‼️ - SRIjkPlayer 释放播放器")
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

/// IJKPlayer - Get
extension SRIjkPlayer {
    public func getVolume() -> Float {
        return ijkPlayer.playbackVolume
    }
    
    public func getDuration() -> TimeInterval {
        return ijkPlayer.duration
    }
    
    public func getCurrentPlaybackTime() -> TimeInterval {
        return ijkPlayer.currentPlaybackTime
    }
    
    public func getVideoCacheDuration() -> TimeInterval {
        return 0.0 // ijkPlayer.videoCacheDuration
    }
    
    public func getPlayableDuration() -> TimeInterval {
        return ijkPlayer.playableDuration
    }
    
    public func getPlayState() -> PlaybackState {
        return PlaybackState.transFrom(ijkPlayer.playbackState)
    }
    
    public func getLoadState() -> PlayLoadState {
        return PlayLoadState.transFrom(ijkPlayer.loadState)
    }
    
    public func getScalingMode() -> ScalingMode {
        return ScalingMode.transFrom(ijkPlayer.scalingMode)
    }
    
    public func getNaturalSize() -> CGSize {
        return ijkPlayer.naturalSize
    }
    
    public func getPlaybackRate() -> PlaybackRate {
        return PlaybackRate(rawValue: ijkPlayer.playbackRate) ?? .rate1x0
    }
    
    public func isPlaying() -> Bool {
        return ijkPlayer.isPlaying()
    }
    
    public func isPrepareToPlay() -> Bool {
        return ijkPlayer.isPreparedToPlay
    }
    
    public func getThumbnailImageAtCurrentTime() -> UIImage? {
        return ijkPlayer.thumbnailImageAtCurrentTime()
    }
}


/// IJKPlayer - Set
extension SRIjkPlayer: VideoPlayer {
    public func seekto(_ offset: CGFloat) {
        if ijkPlayer.currentPlaybackTime + offset < ijkPlayer.duration {
            ijkPlayer.currentPlaybackTime += offset
        }
    }
    
    public func setPlayRate(_ rate: PlaybackRate) {
        ijkPlayer.playbackRate = rate.rawValue
    }
    
    public func setScraModel(_ scaMode: ScalingMode) {
        ijkPlayer.scalingMode = scaMode.transTo()
    }

    public func setAllowsMediaAirPlay(_ airplay: Bool) {
        ijkPlayer.allowsMediaAirPlay = airplay
    }
    
    public func setDanmakuMediaAirPlay(_ airplay: Bool) {
        ijkPlayer.isDanmakuMediaAirPlay = airplay
    }
    
    public func setPlayerVolume(_ playbackVolume: Float) {
        ijkPlayer.playbackVolume = playbackVolume
    }
    
    public func setPauseInBackground(_ pause: Bool) {
        ijkPlayer.setPauseInBackground(pause)
    }
    
    public func setMute() {
        ijkPlayer.playbackVolume = 0.0
    }
    
    public func prepareToPlay() {
        ijkPlayer.prepareToPlay()
    }
    
    public func startPlay() {
        ijkPlayer.play()
    }
    
    public func pause() {
        ijkPlayer.pause()
    }
    
    public func stop() {
        ijkPlayer.stop()
    }
    
    public func shutdown() {
        ijkPlayer.shutdown()
    }
}

/// MARK: -- IJKPlayer 通知
extension SRIjkPlayer {
    private func addObserve(select: Selector, name: Noti) {
        NotificationCenter.default.addObserver(self, selector: select, name: name.name, object: ijkPlayer)
    }
    
    private func remove(_ name: Noti) {
        NotificationCenter.default.removeObserver(self, name: name.name, object: ijkPlayer)
    }
    
    private func removePlayerObserver() {
        [Noti.change, Noti.finish, Noti.isPrepared, Noti.stateChange].forEach {
            remove($0)
        }
    }
    
    private func addPlayerObserver() {
        [(#selector(loadStateDidChange), Noti.change),
         (#selector(moviePlayBackDidFinish), Noti.finish),
         (#selector(mediaIsPreparedToPlayDidChange), Noti.isPrepared),
         (#selector(moviePlayBackStateDidChange), Noti.stateChange)] .forEach {
            addObserve(select: $0.0, name: $0.1)
        }
    }
    
    @objc func loadStateDidChange(_ notification: Notification) {
        if ijkPlayer.loadState.contains(.playthroughOK) {
            SRLogger.debug("playthroughOK")
        } else if ijkPlayer.loadState.contains(.stalled) {
            SRLogger.debug("stateStalled")
        } else {
            SRLogger.debug("loadStateDidChange: ???: \n")
        }
    }
    
    @objc func moviePlayBackDidFinish(_ notification: Notification) {
        let reason = notification.userInfo?[IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as! Int
        switch reason {
        case FinishReason.ended.ijk:
            SRLogger.debug("Finish Ended: \(reason)\n")
        case FinishReason.exited.ijk:
            SRLogger.debug("Finish UserExited: \(reason)\n")
        case FinishReason.error.ijk:
            SRLogger.debug("Finish PlaybackError: \(reason)\n")
        default:
            SRLogger.debug("Finish: ???: \(reason)\n")
        }
        stopPlayer()
        jmSendMsg(msgName: kMsgNameStopPlay, info: nil)
    }
    
    @objc func mediaIsPreparedToPlayDidChange(notification: Notification) {
        SRLogger.debug("mediaIsPreparedToPlayDidChange\n")
        self.gatCuttentTime()
        if !ijkPlayer.shouldAutoplay {
            self.startPlay()
        }
        jmSendMsg(msgName: kMsgNamePrepareToPlay, info: nil)
    }
    
    @objc func moviePlayBackStateDidChange(_ notification: Notification) {
        switch ijkPlayer.playbackState {
        case .stopped:
            SRLogger.debug("stop: stoped")
        case .playing:
            SRLogger.debug("playing: playing")
            jmSendMsg(msgName: kMsgNameStartPlay, info: nil)
        case .paused:
            SRLogger.debug("pause: paused")
        case .interrupted:
            SRLogger.debug("interrupted: interrupted")
            jmSendMsg(msgName: kMsgNameStopPlay, info: nil)
        case .seekingForward:
            SRLogger.debug("seekingBackward: seeking")
        case .seekingBackward:
            SRLogger.debug("seekingBackward: seeking")
        }
    }
}

struct Options {
    static func options() -> IJKFFOptions {
        let options = IJKFFOptions()
        options.setPlayerOptionIntValue(30, forKey: "max-fps")
        options.setPlayerOptionIntValue(30, forKey:"r")
        // 跳帧开关
        options.setPlayerOptionIntValue(1, forKey:"framedrop")
        options.setPlayerOptionIntValue(0, forKey:"start-on-prepared")
        options.setPlayerOptionIntValue(0, forKey:"http-detect-range-support")
        options.setPlayerOptionIntValue(48, forKey:"skip_loop_filter")
        options.setPlayerOptionIntValue(0, forKey:"packet-buffering")
        options.setPlayerOptionIntValue(2000000, forKey:"analyzeduration")
        options.setPlayerOptionIntValue(25, forKey:"min-frames")
        options.setPlayerOptionIntValue(1, forKey:"start-on-prepared")
        options.setCodecOptionIntValue(8, forKey:"skip_frame")
        options.setPlayerOptionValue("nobuffer", forKey: "fflags")
        options.setPlayerOptionValue("8192", forKey: "probsize")
        // 自动转屏开关
        options.setFormatOptionIntValue(0, forKey:"auto_convert")
        // 重连次数
        options.setFormatOptionIntValue(1, forKey:"reconnect")
        // 开启硬解码
        options.setPlayerOptionIntValue(1, forKey:"videotoolbox")
        return options
    }
}
