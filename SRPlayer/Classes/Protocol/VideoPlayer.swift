//
//  Player.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/6.
//

import UIKit

protocol VideoPlayer {
    // 播放器view
    var view: UIView { get }
    // seek
    func seekto(_ offset: CGFloat)
    // 播放速率
    func setPlayRate(_ rate: PlaybackRate)
    // 放缩模式
    func setScraModel(_ scaMode: ScalingMode)
    // 准备播放
    func prepareToPlay()
    // 开始播放
    func startPlay()
    // 暂停播放
    func pause()
    // 停止播放
    func stop()
    // 静音
    func setMute()
    
    // 获取音量
    func getVolume() -> Float
    // 获取播放时长
    func getDuration() -> TimeInterval
    // 获取当前播放时长
    func getCurrentPlaybackTime() -> TimeInterval
    // 获取播放状态
    func getPlayState() -> PlaybackState
    // 获取加载状态
    func getLoadState() -> PlayLoadState
    // 获取缩放状态
    func getScalingMode() -> ScalingMode
    // 获取视频大小
    func getNaturalSize() -> CGSize
    // 获取播放速率
    func getPlaybackRate() -> PlaybackRate
    // 是否正在播放
    func isPlaying() -> Bool
    // 是否准备播放
    func isPrepareToPlay() -> Bool
    // 当前视频截图
    func getThumbnailImageAtCurrentTime() -> UIImage?
}
