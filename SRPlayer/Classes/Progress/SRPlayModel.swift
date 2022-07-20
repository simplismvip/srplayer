//
//  SRModels.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import IJKMediaFrameworkWithSSL

class SRPlayModel {
    var player: IJKMediaPlayback?
    var playView: UIView?
    var isPlaying: Bool = false
    var streamType: StreamType = .vod
    var playState: PlaybackState = .stop
    var loadState: PlayLoadState = .unknow
    var scalingMode : ScalingMode = .none
    var isPrepareToPlay: Bool = false
    var isSwitchingQuality: Bool = false
    var isMute: Bool = false
    var playerDuration: TimeInterval = 0
    var duration: TimeInterval = 0
    var currentPlaybackTime: TimeInterval = 0
    var playableDuration: TimeInterval = 0
    var liveTimeOffset: TimeInterval = 0
    var videoCacheDuration: TimeInterval = 0
    var playbackRate: Float = 0
    var bufferingProgress: Int = 0
    var isSeekBuffering: Int = 0
    var isAudioSync: Int = 0
    var isVideoSync: Int = 0
    var naturalSize: CGSize = CGSize.zero
    var airPlayMediaActive: Bool = false
    
    func setModel(_ player: IJKMediaPlayback?) {
        guard let player = player else {
            return
        }
        
        self.player = player
        streamType = .vod
        isPlaying = player.isPlaying()
        playView = player.view
        currentPlaybackTime = player.currentPlaybackTime
        duration = player.duration
        playableDuration = player.playableDuration
        bufferingProgress = player.bufferingProgress
        isPrepareToPlay = false
        isMute = false
        playState = PlaybackState.transFrom(player.playbackState)
        loadState = PlayLoadState.transFrom(player.loadState)
        
        isSeekBuffering = Int(player.isSeekBuffering)
        isAudioSync = Int(player.isAudioSync)
        isVideoSync = Int(player.isVideoSync)
        naturalSize = player.naturalSize
        scalingMode = ScalingMode.transFrom(player.scalingMode)
        airPlayMediaActive = player.airPlayMediaActive
    }
}

extension SRPlayModel: SRModel { }
