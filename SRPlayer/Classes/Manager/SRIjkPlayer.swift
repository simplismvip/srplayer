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
    var disposes = Set<RSObserver>()
    
    init(_ build: PlayerBulider) {
        self.ijkPlayer = IJKFFMoviePlayerController(contentURL: build.video.videoUrl, with: Options.options())
        self.ijkPlayer.playbackRate = build.playRate.rawValue
        self.view = ijkPlayer.view
        self.streamType = build.stream
        super.init()
        // self.ijkKvo = IJKKVOController(target: self)
        ijkPlayer.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        ijkPlayer.scalingMode = build.scaMode.transTo()
        ijkPlayer.allowsMediaAirPlay = build.mirror
        ijkPlayer.shouldAutoplay = build.autoPlay
        ijkPlayer.prepareToPlay()
        addPlayerObserver()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] _ in
            if let isPlaying = self?.ijkPlayer.isPlaying(), isPlaying {
                self?.jmSendMsg(msgName: kMsgNamePlaybackTimeUpdate, info: nil)
            }
        })
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
        if offset < ijkPlayer.duration {
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
    
    // 弹幕
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
        [Noti.loadChange, Noti.playbackFinish, Noti.isPrepared, Noti.stateChange].forEach {
            remove($0)
        }
    }
    
    private func addPlayerObserver() {
        [(#selector(loadStateDidChange), Noti.loadChange),
         (#selector(moviePlayBackDidFinish), Noti.playbackFinish),
         (#selector(mediaIsPreparedToPlayDidChange), Noti.isPrepared),
         (#selector(moviePlayBackStateDidChange), Noti.stateChange)] .forEach {
            addObserve(select: $0.0, name: $0.1)
        }
    }
    
    @objc func loadStateDidChange(_ notification: Notification) {
        if ijkPlayer.loadState.contains(.playthroughOK) {
            SRLogger.debug("playthroughOK")
            if !ijkPlayer.shouldAutoplay {
                self.startPlay()
            }
        } else if ijkPlayer.loadState.contains(.stalled) {
            SRLogger.debug("stateStalled")
        } else {
            SRLogger.debug("loadStateDidChange: ???: \n")
        }
        jmSendMsg(msgName: kMsgNameRefreashPlayerStatus, info: nil)
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
        // jmSendMsg(msgName: kMsgNameStopPlaying, info: nil)
        jmSendMsg(msgName: kMsgNameRefreashPlayerStatus, info: nil)
    }
    
    @objc func mediaIsPreparedToPlayDidChange(notification: Notification) {
        SRLogger.debug("mediaIsPreparedToPlayDidChange\n")
        jmSendMsg(msgName: kMsgNamePrepareToPlay, info: nil)
    }
    
    @objc func moviePlayBackStateDidChange(_ notification: Notification) {
        switch ijkPlayer.playbackState {
        case .playing:
            SRLogger.debug("playing: playing")
            jmSendMsg(msgName: kMsgNameStartPlay, info: nil)
        case .paused:
            SRLogger.debug("pause: paused")
        case .stopped:
            SRLogger.debug("stopped: stopped")
            // jmSendMsg(msgName: kMsgNameStopPlaying, info: nil)
        case .interrupted:
            jmSendMsg(msgName: kMsgNamePlayerUnknowError, info: nil)
            SRLogger.debug("interrupted: interrupted")
        case .seekingForward, .seekingBackward:
            SRLogger.debug("seekingBackward: seeking")
        @unknown default:
            SRLogger.debug("seekingBackward: seeking")
        }
        jmSendMsg(msgName: kMsgNameRefreashPlayerStatus, info: nil)
    }
}

struct Options {
    static func options(_ living: Bool = false) -> IJKFFOptions {
        let options = IJKFFOptions()
        // 设置帧率大小
        options.setPlayerOptionIntValue(30, forKey: "max-fps")
        // 最小帧率
        options.setPlayerOptionIntValue(25, forKey:"min-frames")
        // 设置缓存,太小了视频就处于边播边加载的状态，目前是10M，后期可以调整
        options.setPlayerOptionIntValue(10*1024*1024, forKey: "max-buffer-size")
        // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）帧速率越大,画质越好）
        options.setPlayerOptionIntValue(Int64(29.97), forKey:"r")
        // 跳帧开关，如果cpu解码能力不足，可以设置成5，否则
        // 会引起音视频不同步，也可以通过设置它来跳帧达到倍速播放
        options.setPlayerOptionIntValue(1, forKey:"framedrop")
        // 打开h265硬解
        options.setPlayerOptionIntValue(1, forKey:"mediacodec-hevc")
        
        options.setPlayerOptionIntValue(0, forKey:"start-on-prepared")
        options.setPlayerOptionIntValue(0, forKey:"http-detect-range-support")
        // IJK_AVDISCARD_DEFAULT
        // 解码参数，画面更清晰
        options.setPlayerOptionIntValue(48, forKey:"skip_loop_filter")
        options.setCodecOptionIntValue(8, forKey:"skip_frame")
        
        if living {
            // 最大缓存大小是3秒，可以依据自己的需求修改
            options.setPlayerOptionIntValue(3000, forKey:"max_cached_duration")
            // 设置无极限的播放器buffer，这个选项常见于实时流媒体播放场景
            options.setPlayerOptionIntValue(1, forKey:"infbuf")
            // 播放器缓冲可以避免因为丢帧引入花屏的，因为丢帧都是丢到I帧之前的P/B帧为止。我之前也写过一个类似的，思路都是一样，但这个代码更精简。
            // A：如果你想要实时性，可以去掉缓冲区，一句代码：
            // B: 如果你这样试过，发现你的项目中播放频繁卡顿，
            // 你想留1-2秒缓冲区，让数据更平缓一些，
            // 那你可以选择保留缓冲区，不设置上面那个就行。
            options.setPlayerOptionIntValue(0, forKey:"packet-buffering")
        } else {
            // 如果不判断是否是关键帧会导致视频画面花屏。但是这样会导致全部清空的可能也会出现花屏
            // 所以这里推流端设置好 GOP（画面组，一个GOP就是一组连续的画面。MPEG编码将画面（即帧）分为I、P、B三种） 的大小，如果 max_cached_duration > 2 * GOP，可以尽可能规避全部清空
            // 也可以在调用control_queue_duration之前判断新进来的视频pkt是否是关键帧，这样即使全部清空了也不会花屏。
            options.setPlayerOptionIntValue(1, forKey:"packet-buffering")
            options.setPlayerOptionIntValue(0, forKey:"max_cached_duration")
            options.setPlayerOptionIntValue(0, forKey:"infbuf")
        }
        
        // 开始准备
        options.setPlayerOptionIntValue(1, forKey:"start-on-prepared")
        // 播放前的探测Size，默认是1M, 改小一点会出画面更快
        options.setPlayerOptionValue("1024 * 16", forKey: "probsize")
        // 播放前的探测时间
        options.setPlayerOptionIntValue(50000, forKey:"analyzeduration")
        // 设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推）
        options.setFormatOptionIntValue(512, forKey:"vol")
        // 自动转屏开关
        options.setFormatOptionIntValue(0, forKey:"auto_convert")
        // 重连次数
        options.setFormatOptionIntValue(1, forKey:"reconnect")
        // 暂时关闭硬解码，有声音视频推到后台再返回画面不动
        // https://github.com/bilibili/ijkplayer/issues/3328
        options.setPlayerOptionIntValue(0, forKey:"videotoolbox")
        return options
    }
}
