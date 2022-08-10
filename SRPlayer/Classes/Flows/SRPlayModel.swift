//
//  SRModels.swift
//  Pods-SRPlayer_Example
//
//  Created by JunMing on 2022/7/18.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class SRPlayModel: NSObject {
    @objc dynamic var isPlaying: Bool = false
    @objc dynamic var isPrepareToPlay: Bool = false
    @objc dynamic var airPlayMediaActive: Bool = false
    @objc dynamic var duration: TimeInterval = 0
    @objc dynamic var currentTime: TimeInterval = 0
    @objc dynamic var playableDuration: TimeInterval = 0
    @objc dynamic var cacheDuration: TimeInterval = 0
    @objc dynamic var thumbImage: UIImage?
    @objc dynamic var playRateStr: String = "倍速"
    @objc dynamic var playbackVolume: Float = 0
    
    var playState: PlaybackState = .stop
    var loadState: PlayLoadState = .unknow
    var scalingMode : ScalingMode = .none
    
    var isMute: Bool {
        return playbackVolume > 0
    }
    
    var playbackRate: PlaybackRate = .rate1x0 {
        willSet {
            playRateStr = newValue.name
        }
    }
    
    var naturalSize: CGSize = CGSize.zero
    var panSeekTargetTime: CGFloat = 0
    var panSeekOffsetTime: CGFloat = 0
}

extension SRPlayModel {
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
