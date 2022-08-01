//
//  SRPlayerEnum.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import IJKMediaFrameworkWithSSL

// 屏幕类型
public enum ScreenType {
    case half // 半平
    case full // 全屏
}

// 屏幕状态
public enum ScreenState {
    case lock // 锁定
    case unlock // 解锁
}

// 流类型
public enum StreamType {
    case vod // 锁定
    case live // 解锁
}

public enum PlaybackRate: CGFloat {
    case rate0x75 = 0.75 // 0.75x
    case rate1x0 = 1.0 // 1.0x
    case rate1x25 = 1.25 // 1.25x
    case rate1x5 = 1.5 // 1.5x
    case rate2x0 = 2.0 // 2.0x
}

public enum PlaybackState {
    case stop // 停止
    case playing // 播放
    case pause // 暂停
    case interrupted // 打断
    case seekingForward // 前进
    case seekingBackward // 后退
    
    static func transFrom(_ ijkState: IJKMPMoviePlaybackState) -> PlaybackState {
        switch ijkState {
        case .stopped:
            return .stop
        case .playing:
            return .playing
        case .interrupted:
            return .interrupted
        case .seekingForward:
            return .seekingForward
        case .seekingBackward:
            return seekingBackward
        case .paused:
            return .pause
        }
    }
    
    func transFrom() -> IJKMPMoviePlaybackState {
        switch self {
        case .stop:
            return .stopped
        case .playing:
            return .playing
        case .interrupted:
            return .interrupted
        case .seekingForward:
            return .seekingForward
        case .seekingBackward:
            return .seekingBackward
        case .pause:
            return .paused
        }
    }
}

public enum PlayLoadState {
    case unknow // 未知
    case playable // 准备完成
    case playthroughOK // Playback will be automatically started in this state when shouldAutoplay is YES
    case stateStalled // Playback will be automatically paused in this state, if started
    
    static func transFrom(_ ijkState: IJKMPMovieLoadState) -> PlayLoadState {
        switch ijkState {
        case .playable:
            return .playable
        case .playthroughOK:
            return .playthroughOK
        case .stalled:
            return .stateStalled
        default:
            return .unknow
        }
    }
    
    func transTo() -> IJKMPMovieLoadState {
        switch self {
        case .playable:
            return .playable
        case .playthroughOK:
            return .playthroughOK
        case .stateStalled:
            return .stalled
        default:
            return []
        }
    }
}

public enum ScalingMode {
    case none
    case aspectFit
    case aspectFill
    case fill
    
    static func transFrom(_ ijkMode: IJKMPMovieScalingMode) -> ScalingMode {
        switch ijkMode {
        case .none:
            return .none
        case .aspectFit:
            return .aspectFit
        case .aspectFill:
            return .aspectFill
        case .fill:
            return .fill
        }
    }
    
    func transTo() -> IJKMPMovieScalingMode {
        switch self {
        case .none:
            return .none
        case .aspectFit:
            return .aspectFit
        case .aspectFill:
            return .aspectFill
        case .fill:
            return .fill
        }
    }
}

enum FinishReason {
    case ended
    case error
    case exited
    
    static func transFrom(_ ijkReaseon: IJKMPMovieFinishReason) -> FinishReason {
        switch ijkReaseon {
        case .playbackEnded:
            return .ended
        case .playbackError:
            return .error
        case .userExited:
            return .exited
        }
    }
    
    var ijk: Int {
        switch self {
        case .ended:
            return IJKMPMovieFinishReason.playbackEnded.rawValue
        case .error:
            return IJKMPMovieFinishReason.playbackError.rawValue
        case .exited:
            return IJKMPMovieFinishReason.userExited.rawValue
        }
    }
}
