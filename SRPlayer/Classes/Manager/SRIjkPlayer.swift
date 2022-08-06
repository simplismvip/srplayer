//
//  SRIjkPlayer.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/31.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import IJKMediaFrameworkWithSSL
import ZJMKit

class SRIjkPlayer: NSObject {
    /** 显示视频的视图 */
    let view: UIView
    /** 播放流类型 */
    var streamType: StreamType
    /** 播放器播放状态 */
    var playState: PlaybackState = .stop
    /** 播放器载入状态 */
    var loadState: PlayLoadState = .unknow
    /** 缩放模式 */
    var scalingMode : ScalingMode = .none
    /** 结束播放原因 */
    var finish: FinishReason?
    /** 是否准备播放 */
    var isPrepareToPlay: Bool = false
//    /** 是否正在切换视频质量 */
//    var isSwitchingQuality: Bool = false
    /** 是否静音 */
    var isMute: Bool = false
    /** 是否准备播放 */
    var playerDuration: TimeInterval = 0
    /** 视频时长，如果是直播，则为0,单位是秒 */
    var duration: TimeInterval = 0
    /** 当前播放时间,单位是秒 */
    @objc dynamic var currentTime: TimeInterval = 0
    /** 可以播放时长 */
    var playableDuration: TimeInterval = 0
    /** 偏移时长 */
    var liveTimeOffset: TimeInterval = 0
    /** 视频缓存时长 */
    var videoCacheDuration: TimeInterval = 0
    /** 播放速率 */
    var playbackRate: PlaybackRate
    /** buffer时长 */
    var bufferingProgress: Int = 0
    /** 可以播放时长 */
    var isSeekBuffering: Int = 0
    /** 可以播放时长 */
    var isAudioSync: Int = 0
    /** 可以播放时长 */
    var isVideoSync: Int = 0
    /** 视频宽高信息 */
    var naturalSize: CGSize = CGSize.zero
    /** 可以播放时长 */
    var airPlayMediaActive: Bool = false
    var volume: Float = 0
    /** 播放器 */
    private var ijkPlayer: IJKFFMoviePlayerController
    /** kvo监听 */
    private var ijkKvo: IJKKVOController?
    /** 开启时间循环 */
    private var timer: Timer?
    
    init(_ build: PlayerBulider) {
        self.ijkPlayer = IJKFFMoviePlayerController(contentURL: build.url, with: Options.options())
        self.streamType = build.streamType
        self.playbackRate = build.playbackRate
        self.view = ijkPlayer.view
        super.init()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(gatCuttentTime), userInfo: nil, repeats: true)
        // self.ijkKvo = IJKKVOController(target: self)
        ijkPlayer.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        ijkPlayer.scalingMode = build.scaMode.transTo()
        ijkPlayer.allowsMediaAirPlay = build.allowsAirPlay
        ijkPlayer.shouldAutoplay = build.shouldAutoplay
        ijkPlayer.prepareToPlay()
        addPlayerObserver()
    }
    
    public func associatedRouter(_ router: JMRouter?) {
        guard let r = router else { return }
        jmSetAssociatedMsgRouter(router: r)
    }
    
    func stopPlayer() {
        playState = .stop
        timer?.invalidate()
        timer = nil
        stop()
        shutdown()
        ijkPlayer.view.removeFromSuperview()
        removePlayerObserver()
    }

    @objc private func gatCuttentTime() {
        if ijkPlayer.isPlaying() {
            if currentTime != ijkPlayer.currentPlaybackTime {
                currentTime = ijkPlayer.currentPlaybackTime
            }
            
            if duration != ijkPlayer.duration {
                duration = ijkPlayer.duration
            }
            
            if playableDuration != ijkPlayer.playableDuration {
                playableDuration = ijkPlayer.playableDuration
            }
            
            if volume != ijkPlayer.playbackVolume {
                volume = ijkPlayer.playbackVolume
                isMute = !(volume > 0)
            }
            jmSendMsg(msgName: kMsgNamePlaybackTimeUpdate, info: nil)
        }
    }
    
    deinit {
        SRLogger.debug("‼️‼️‼️‼️‼️‼️ - SRIjkPlayer 释放播放器")
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

/// Public Func
extension SRIjkPlayer: VideoPlayer {
    public func seekto(_ offset: CGFloat) {
        if ijkPlayer.currentPlaybackTime + offset < ijkPlayer.duration {
            ijkPlayer.currentPlaybackTime += offset
        }
    }
    
    public func playRate(_ rate: PlaybackRate) {
        ijkPlayer.playbackRate = rate.rawValue
    }
    
    public func scraModel(_ scaMode: ScalingMode) {
        ijkPlayer.scalingMode = scaMode.transTo()
    }
    
    public func isPlaying() -> Bool {
        return ijkPlayer.isPlaying()
    }
    
    public func thumbnailImageAtCurrentTime() -> UIImage? {
        return ijkPlayer.thumbnailImageAtCurrentTime()
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
    
    public func setMute() {
        ijkPlayer.playbackVolume = 0.0
    }
    
    public func shutdown() {
        ijkPlayer.shutdown()
    }
    
    public func setPauseInBackground(_ pause: Bool) {
        ijkPlayer.setPauseInBackground(pause)
    }
}

/// MARK: -- IJKPlayer 通知
extension SRIjkPlayer {
    struct Action {
        var name: String
        var target: NSObject
        var select: Selector
    }
    
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
            loadState = .playthroughOK
            SRLogger.debug("playthroughOK")
        } else if ijkPlayer.loadState.contains(.stalled) {
            SRLogger.debug("stateStalled")
            loadState = .stateStalled
        } else {
            SRLogger.debug("loadStateDidChange: ???: \(loadState)\n")
        }
    }
    
    @objc func moviePlayBackDidFinish(_ notification: Notification) {
        let reason = notification.userInfo?[IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as! Int
        switch reason {
        case FinishReason.ended.ijk:
            SRLogger.debug("Finish Ended: \(reason)\n")
            finish = .ended
        case FinishReason.exited.ijk:
            SRLogger.debug("Finish UserExited: \(reason)\n")
            finish = .exited
        case FinishReason.error.ijk:
            SRLogger.debug("Finish PlaybackError: \(reason)\n")
            finish = .error
        default:
            SRLogger.debug("Finish: ???: \(reason)\n")
        }
        stopPlayer()
        jmSendMsg(msgName: kMsgNameStopPlay, info: finish as MsgObjc)
    }
    
    @objc func mediaIsPreparedToPlayDidChange(notification: Notification) {
        SRLogger.debug("mediaIsPreparedToPlayDidChange\n")
        self.isPrepareToPlay = true
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
            playState = .stop
        case .playing:
            SRLogger.debug("playing: playing")
            playState = .playing
            jmSendMsg(msgName: kMsgNameStartPlay, info: nil)
        case .paused:
            SRLogger.debug("pause: paused")
            playState = .pause
        case .interrupted:
            SRLogger.debug("interrupted: interrupted")
            playState = .interrupted
            jmSendMsg(msgName: kMsgNameStopPlay, info: nil)
        case .seekingForward:
            SRLogger.debug("seekingBackward: seeking")
            playState = .seekingForward
        case .seekingBackward:
            SRLogger.debug("seekingBackward: seeking")
            playState = .seekingBackward
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
