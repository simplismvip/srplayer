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
    @objc dynamic var playbackVolume: Float = 0
    // 当前视频的标题
    @objc dynamic var videoTitle: String?
    
    // 播放器状态
    @objc dynamic var playingStatue: String = ""
    var playState: PlaybackState = .stop {
        willSet {
            playingStatue = newValue.name
        }
    }
    
    // 加载状态，绑定loading动画
    @objc dynamic var loadingStatue: String = ""
    var loadState: PlayLoadState = .unknow {
        willSet {
            loadingStatue = newValue.name
        }
    }
    
    @objc dynamic var scaleImage: String = "sr_scare_big"
    var scalingMode : ScalingMode = .aspectFit {
        willSet {
            scaleImage = newValue.name
        }
    }
    
    @objc dynamic var playRateStr: String = "倍速"
    var playbackRate: PlaybackRate = .rate1x0 {
        willSet {
            playRateStr = newValue.name
        }
    }
    
    var naturalSize: CGSize = CGSize.zero
    var panSeekTargetTime: CGFloat = 0
    var panSeekOffsetTime: CGFloat = 0
    // 系统音量
    var systemVolume: CGFloat = 0
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
    
    var isMute: Bool {
        return playbackVolume > 0
    }
    
    // seek进度
    var seekTimeString: String {
        return String(format: "%@/%@", Int(panSeekTargetTime + panSeekOffsetTime).format, Int(duration).format)
    }
    
    var seekProgress: Double {
        return (panSeekTargetTime + panSeekOffsetTime) / duration
    }
}

extension SRPlayModel: SRModel { }
