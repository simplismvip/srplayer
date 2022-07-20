//
//  SRPlayerEnum.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

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

public enum PlaybackState {
    case stop // 停止
    case playing // 播放
    case pause // 暂停
    case interrupted // 打断
    case seekingForward // 前进
    case seekingBackward // 后退
}

public enum PlayLoadState {
    case unknow // 未知
    case playable // 准备完成
    case playthroughOK //  在这个状态下,如果shouldAutoplay == YES时，视频将立即播放
    case stateStalled // 在这个状态下，视频将停止播放
}
