//
//  SRModels.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class SRPlayModel: NSObject {
    @objc dynamic var isMute: Bool = false
    @objc dynamic var isPlaying: Bool = false
    @objc dynamic var isPrepareToPlay: Bool = false
    var airPlayMediaActive: Bool = false
    var playState: PlaybackState = .stop
    var loadState: PlayLoadState = .unknow
    var scalingMode : ScalingMode = .none
    
    var playbackRate: PlaybackRate = .rate1x0
    @objc dynamic var duration: TimeInterval = 0
    @objc dynamic var currentTime: TimeInterval = 0
    @objc dynamic var cacheDuration: TimeInterval = 0
    var naturalSize: CGSize = CGSize.zero
    
    // 当前进度
    var progress: Double {
        if duration > 0 {
            return currentTime/duration
        } else {
            return 0.0
        }
    }
}

extension SRPlayModel: SRModel { }
