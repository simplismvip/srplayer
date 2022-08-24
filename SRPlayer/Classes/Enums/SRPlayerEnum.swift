//
//  SRPlayerEnum.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import IJKMediaFramework

// 屏幕类型
public enum ScreenType {
    case half // 半平
    case full // 全屏
}

// 屏幕状态
public enum ScreenState {
    case lock   // 锁定
    case unlock // 解锁
}

// 流类型
public enum StreamType: Int {
    case vod = 0   // 锁定
    case live = 1  // 解锁
}

extension StreamType: Codable { }

enum ToastStatus {
    case show     // 展示
    case update   // 更新
    case hide     // 隐藏
}

public enum ToastType {
    case seek(Float, String)   // 快进 快退
    case longPress             // 长按快进
    case volume (Float)        // 音量
    case brightness(Float)     // 亮度
    case loading               // 加载动画
    case netSpeed(String)      // 加载动画、网速
    case seekAction(Float, String)  // seek切换
    case screenShot(CGPoint, UIImage)  // 截屏
    
    var name: String {
        switch self {
        case .seek:
            return "sr_forward"
        case .longPress:
            return "sr_longpress"
        case .volume:
            return "sr_volum"
        case .brightness:
            return "sr_ brightness"
        case .loading:
            return "loading"
        case .screenShot:
            return "screenShot"
        case .netSpeed:
            return "netSpeed"
        case .seekAction:
            return "seekAction"
        }
    }
}

extension ToastType: Equatable { }

public enum PlaybackRate: Float {
    case rate0x75 = 0.75   // 0.75x
    case rate1x0 = 1.0     // 1.0x
    case rate1x25 = 1.25   // 1.25x
    case rate1x5 = 1.5     // 1.5x
    case rate2x0 = 2.0     // 2.0x
    
    var name: String {
        switch self {
        case .rate0x75:
            return "0.75X"
        case .rate1x0:
            return "倍速"
        case .rate1x25:
            return "0.25X"
        case .rate1x5:
            return "1.5X"
        case .rate2x0:
            return "2.0X"
        }
    }
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
        @unknown default:
            fatalError()
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
    
    var name: String {
        switch self {
        case .stop:
            return "播放停止"
        case .playing:
            return "播放中..."
        case .pause:
            return "暂停播放"
        case .interrupted:
            return "播放被打断"
        case .seekingForward:
            return "快进"
        case .seekingBackward:
            return "快退"
        }
    }
}

public enum PlayLoadState {
    case unknow // 未知
    case playable // 准备完成
    case playthroughOK // Playback will be automatically started in this state when shouldAutoplay is YES
    case stateStalled // Playback will be automatically paused in this state, if started
    
    static func transFrom(_ ijkState: IJKMPMovieLoadState) -> PlayLoadState {
        if ijkState.contains(.playable) {
            return PlayLoadState.playable
        } else if ijkState.contains(.playthroughOK) {
            return PlayLoadState.playthroughOK
        } else if ijkState.contains(.stalled) {
            return PlayLoadState.stateStalled
        } else {
            return PlayLoadState.unknow
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
    
    var name: String {
        switch self {
        case .unknow:
            return "未知状态"
        case .playable:
            return "准备播放"
        case .playthroughOK:
            return "开始播放"
        case .stateStalled:
            return "缓冲中..."
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
        @unknown default:
            fatalError()
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
    
    var name: String {
        switch self {
        case .aspectFit:
            return "sr_scare_big"
        case .aspectFill:
            return "sr_scare_small"
        case .fill:
            return "sr_scare_small"
        case .none:
            return "sr_scare_big"
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
        @unknown default:
            fatalError()
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
