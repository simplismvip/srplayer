//
//  SRModels.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class SRPlayModel {
    var isPlaying: Bool = false
    var playView: UIView?
    var streamType: StreamType = .vod
    var playState: PlaybackState = .stop
    var loadState: PlayLoadState = .unknow
    var isPrepareToPlay: Bool = false
    var isSwitchingQuality: Bool = false
    var isMute: Bool = false
    var playerDuration: TimeInterval = 0
    var currentPlaybackTime: TimeInterval = 0
    var liveTimeOffset: TimeInterval = 0
    var videoCacheDuration: TimeInterval = 0
    var playbackRate: Float = 0
}

extension SRPlayModel: SRModel { }
