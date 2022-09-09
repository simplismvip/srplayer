//
//  SRVLCPlayer.swift
//  SRPlayer
//
//  Created by jh on 2022/9/9.
//

import UIKit
import ZJMKit
import MobileVLCKit

class SRVLCPlayer: NSObject {
    /// 显示视频的视图
    let view: UIView
    /// 播放流类型
    var streamType: StreamType
    /// 当前播放的视频资源
    var videoInfo: PlayerBulider.Video
    // 播放器
    let vlcPlayer: VLCMediaPlayer
    
    init(_ build: PlayerBulider, playerView: UIView) {
        streamType = build.stream
        videoInfo = build.video
        vlcPlayer = VLCMediaPlayer()
        view = playerView
        super.init()
        vlcPlayer.media = VLCMedia(url: build.video.videoUrl)
        JMLogger.debug("url:\(build.video.videoUrl.absoluteString)")
        vlcPlayer.rate = build.playRate.rawValue
        vlcPlayer.drawable = playerView
        vlcPlayer.delegate = self
        vlcPlayer.play()
    }
    
    public func associatedRouter(_ router: JMRouter?) {
        guard let r = router else { return }
        jmSetAssociatedMsgRouter(router: r)
    }
    
    public func stopPlayer() {
        vlcPlayer.stop()
    }

    deinit {
        JMLogger.debug("‼️‼️‼️‼️‼️‼️ - SRIjkPlayer 释放播放器")
        JMLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

// MARK: - 视频播放
extension SRVLCPlayer: VLCMediaPlayerDelegate {
    func mediaPlayerStateChanged(_ aNotification: Notification) {
        guard let player = aNotification.object as? VLCMediaPlayer else {
            return
        }
        // VLCMediaPlayerState
        switch player.state {
        case .opening:
            jmSendMsg(msgName: kMsgNamePrepareToPlay, info: nil)
            JMLogger.debug("PlayingState:opening")
        case .buffering:
            JMLogger.debug("PlayingState:buffering")
            jmSendMsg(msgName: kMsgNameRefreashPlayerStatus, info: nil)
        case .ended, .stopped:
            jmSendMsg(msgName: kMsgNamePausePlayEnding, info: nil)
            JMLogger.debug("PlayingState:ended & stopped")
        case .paused:
            jmSendMsg(msgName: kMsgNamePausePlayEnding, info: nil)
            JMLogger.debug("PlayingState:paused")
        case .error:
            jmSendMsg(msgName: kMsgNamePlayerUnknowError, info: nil)
            JMLogger.debug("PlayingState:error")
        case .playing:
            jmSendMsg(msgName: kMsgNameStartPlaying, info: nil)
            JMLogger.debug("PlayingState:playing")
        case .esAdded:
            JMLogger.debug("PlayingState:esAdded")
        default:
            JMLogger.debug("PlayingState:default")
            jmSendMsg(msgName: kMsgNameRefreashPlayerStatus, info: nil)
        }
    }
    
    func mediaPlayerTimeChanged(_ aNotification: Notification) {
        guard let player = aNotification.object as? VLCMediaPlayer else {
            return
        }
        JMLogger.debug("\(player.current / player.duration)--\(player.state)")
        jmSendMsg(msgName: kMsgNamePlaybackTimeUpdate, info: nil)
    }
    
    func mediaPlayerTitleChanged(_ aNotification: Notification!) {
        
    }
    
    func mediaPlayerChapterChanged(_ aNotification: Notification!) {
        
    }
    
    // 音量改变
    func mediaPlayerLoudnessChanged(_ aNotification: Notification!) {
        
    }
    
    func mediaPlayerSnapshot(_ aNotification: Notification!) {
        
    }
    
    func mediaPlayerStartedRecording(_ player: VLCMediaPlayer!) {
        
    }
    
    func mediaPlayer(_ player: VLCMediaPlayer!, recordingStoppedAtPath path: String!) {
        
    }
}

extension SRVLCPlayer: VideoPlayer {
    func getVolume() -> Float {
        return Float(vlcPlayer.audio.volume)
    }
    
    func getPosition() -> Double {
        return Double(vlcPlayer.position)
    }
    
    func getDuration() -> TimeInterval {
        return vlcPlayer.duration
    }
    
    func getCurrentPlaybackTime() -> TimeInterval {
        return vlcPlayer.current
    }
    
    func getPlayState() -> PlaybackState {
        return PlaybackState.transVLCFrom(vlcPlayer.state)
    }
    
    func getLoadState() -> PlayLoadState {
        switch vlcPlayer.state {
        case .buffering:
            return .stateStalled
        default:
            return .playthroughOK
        }
    }
    
    func getScalingMode() -> ScalingMode {
        return .aspectFill
    }
    
    func getNaturalSize() -> CGSize {
        return vlcPlayer.videoSize
    }
    
    func getPlaybackRate() -> PlaybackRate {
        return .rate0x75
    }
    
    func isPlaying() -> Bool {
        return vlcPlayer.isPlaying
    }
    
    func isPrepareToPlay() -> Bool {
        return vlcPlayer.willPlay
    }
    
    func getThumbnailImageAtCurrentTime() -> UIImage? {
        return vlcPlayer.lastSnapshot
    }
    
    public func seekto(_ seekTo: CGFloat) {
        if !vlcPlayer.isSeekable { return }
        
        if seekTo < vlcPlayer.duration {
            // 设置当前视频时间
            let vlctime = VLCTime(int: Int32(seekTo))
            self.vlcPlayer.time = vlctime
        }
    }
    
    public func setPlayRate(_ rate: PlaybackRate) {
         vlcPlayer.rate = rate.rawValue
    }
    
    public func setScraModel(_ scaMode: ScalingMode) {
        // vlcPlayer.scalingMode = scaMode.transTo()
    }
    
    public func setMute() {
        vlcPlayer.audio.isMuted = true
    }
    
    public func prepareToPlay() {
        
    }
    
    public func startPlay() {
        vlcPlayer.play()
    }
    
    public func pause() {
        vlcPlayer.pause()
    }
    
    public func stop() {
        vlcPlayer.stop()
    }
}

extension VLCMediaPlayer {
    var duration: CGFloat {
        return CGFloat(media.length.intValue) / 1000
    }
    
    var current: CGFloat {
        return CGFloat(time.intValue) / 1000
    }
}
