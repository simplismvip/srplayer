//
//  Player.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/6.
//

import UIKit

public protocol VideoPlayer {
    // 播放器view
    var view: UIView { get }
    // seek
    func seekto(_ offset: CGFloat)
    // 播放速率
    func playRate(_ rate: PlaybackRate)
    // 放缩模式
    func scraModel(_ scaMode: ScalingMode)
    // 是否正在播放
    func isPlaying() -> Bool
    // 当前视频截图
    func thumbnailImageAtCurrentTime() -> UIImage?
    // 是否允许airplay
    func setAllowsMediaAirPlay(_ airplay: Bool)
    
    func setDanmakuMediaAirPlay(_ airplay: Bool)
    // 播放器音量
    func setPlayerVolume(_ playbackVolume: Float)
    // 准备博哦饭
    func prepareToPlay()
    // 开始播放
    func startPlay()
    // 暂停播放
    func pause()
    // 停止播放
    func stop()
    // 静音
    func setMute()
    // 关闭
    func shutdown()
}
