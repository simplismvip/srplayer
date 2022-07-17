//
//  SRPlayerManager.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//

import UIKit
import IJKMediaFrameworkWithSSL

class SRPlayerManager: SRPlayerProtocol {
    var playView: UIView
    var streamType: StreamType
    var playState: PlaybackState
    var loadState: PlayLoadState
    var isPlayer: Bool
    var isPrepareToPlay: Bool
    var isSwitchingQuality: Bool
    var isMute: Bool
    var playerDuration: TimeInterval
    var currentPlaybackTime: TimeInterval
    var liveTimeOffset: TimeInterval
    var videoCacheDuration: TimeInterval
    var playbackRate: Float
    
    init() {
        playView = UIView()
        streamType = .live
        playState = .pause
        loadState = .stateStalled
        isPlayer = false
        isPrepareToPlay = false
        isSwitchingQuality = false
        isMute = false
        playerDuration = 0
        currentPlaybackTime = 0
        liveTimeOffset = 0
        videoCacheDuration = 0
        playbackRate = 0
    }
}
