//
//  SRVideoProtocol.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//

import UIKit

public protocol SRPlayerProtocol {
    var playView: UIView { get }
    var streamType: StreamType { get }
    var playState: PlaybackState { get set }
    var loadState: PlayLoadState { get set }
    var isPlayer: Bool { get set }
    var isPrepareToPlay: Bool { get set }
    var isSwitchingQuality: Bool { get set }
    var isMute: Bool { get set }
    /// 播放器SDK时长 或直播自己计算的总时长
    var playerDuration: TimeInterval { get set }
    /// 当前播放时间
    var currentPlaybackTime: TimeInterval { get set }
    /// 直播流时移时间
    var liveTimeOffset: TimeInterval { get set }
    /// 已缓冲的秒数
    var videoCacheDuration: TimeInterval { get set }
    /// 播放速率
    var playbackRate: Float { get set }
}
