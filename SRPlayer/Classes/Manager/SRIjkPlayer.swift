//
//  SRIjkPlayer.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/31.
//

import UIKit
import IJKMediaFrameworkWithSSL

class SRIjkPlayer: NSObject {
//    IJKMediaPlayback
    /** 显示视频的视图 */
    var playView: UIView?
    /** 是否播放 */
    var isPlaying: Bool = false
    /** 播放流类型 */
    var streamType: StreamType = .vod
    /** 播放器播放状态 */
    var playState: PlaybackState = .stop
    /** 播放器载入状态 */
    var loadState: PlayLoadState = .unknow
    /** 缩放模式 */
    var scalingMode : ScalingMode = .none
    /** 是否准备播放 */
    var isPrepareToPlay: Bool = false
    /** 是否正在切换视频质量 */
    var isSwitchingQuality: Bool = false
    /** 是否静音 */
    var isMute: Bool = false
    /** 是否准备播放 */
    var playerDuration: TimeInterval = 0
    /** 视频时长，如果是直播，则为0,单位是秒 */
    var duration: TimeInterval = 0
    /** 当前播放时间,单位是秒 */
    var currentPlaybackTime: TimeInterval = 0
    /** 可以播放时长 */
    var playableDuration: TimeInterval = 0
    /** 偏移时长 */
    var liveTimeOffset: TimeInterval = 0
    /** 视频缓存时长 */
    var videoCacheDuration: TimeInterval = 0
    /** 播放速率 */
    var playbackRate: Float = 0
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
    /** 播放器 */
    private var player: IJKMediaPlayback
    /** kvo监听 */
    private var kvo: IJKKVOController?
    
    init(url: URL) {
        self.player = IJKFFMoviePlayerController(contentURL: url, with: Options.options())
        super.init()
        self.kvo = IJKKVOController(target: self)
//        player?.view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        player?.scalingMode = .aspectFit
//        player?.allowsMediaAirPlay = true
//        player?.shouldAutoplay = true
//        player?.prepareToPlay()
    }
    
    func prepareToPlay() {
//        IJKMediaEvent
    }
    
    func aplay() {
        
    }
    
    func pause() {
        
    }
    
    func stop() {
        
    }
    
    func setMute() {
        
    }
    
    func shutdown() {
        
    }
    
    func setPauseInBackground(_ pause: Bool) {
        
    }
}

extension SRIjkPlayer {
    @objc func loadStateDidChange(_ notification: Notification) {
        if let loadState = player?.loadState {
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
        guard player != nil else {
            return
        }
        switch player!.playbackState {
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
extension SRIjkPlayer {
    public func thumbnailImageAtCurrentTime() -> UIImage? {
        return player.thumbnailImageAtCurrentTime()
    }
    
    public func setAllowsMediaAirPlay(_ airplay: Bool) {
        player.allowsMediaAirPlay = airplay
    }
    
    public func setDanmakuMediaAirPlay(_ airplay: Bool) {
        player.isDanmakuMediaAirPlay = airplay
    }
    
    public func setPlayerRate(_ playbackRate: Float) {
        player.playbackRate = playbackRate
    }
    
    public func setPlayerVolume(_ playbackVolume: Float) {
        player.playbackVolume = playbackVolume
    }
}


extension SRIjkPlayer {
    private func addKVOObaser() {
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "currentPlaybackTime", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "duration", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "playableDuration", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "bufferingProgress", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "isPreparedToPlay", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "playbackState", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "loadState", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "isSeekBuffering", options: [.new, .initial], context: nil)
        
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "isAudioSync", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "isVideoSync", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "numberOfBytesTransferred", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "bufferingProgress", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "isPreparedToPlay", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "playbackState", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "loadState", options: [.new, .initial], context: nil)
        self.kvo?.safelyAddObserver(self.player as? NSObject, forKeyPath: "isSeekBuffering", options: [.new, .initial], context: nil)
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
