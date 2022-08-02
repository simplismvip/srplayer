//
//  EventsName.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import Foundation

// ------------- Msg Name -------------
// 起播
/// 准备初始化
public let kMsgNamePlayStartSetup = "kMsgNamePlayStartSetup"
/// 准备播放
public let kMsgNamePrepareToPlay = "kMsgNamePrepareToPlay"
/// 开始播放
public let kMsgNameStartPlay = "kMsgNameStartPlay"
/// 正在播放
public let kMsgNameCurrentPlaying = "kMsgNameCurrentPlaying"
/// 停止播放
public let kMsgNameStopPlay = "kMsgNameStopPlay"
/// 结束播放
public let kMsgNameFinishedPlay = "kMsgNameFinishedPlay"
/// 暂停播放
public let kMsgNamePauseOrRePlay = "kMsgNamePauseOrRePlay"
/// 播放
public let kMsgNameRePlay = "kMsgNameRePlay"
/// 播放
public let kMsgNameActionPlay = "kMsgNameActionPlay"
/// 快进快退
public let kMsgNameActionSeekTo = "kMsgNameActionSeekTo"
/// 切换清晰度
public let kMsgNameSwitchQuality = "kMsgNameSwitchQuality"
/// 静音
public let kMsgNameActionMute = "kMsgNameActionMute"
/// 更改播放速率
public let kMsgNameChangePlaybackRate = "kMsgNameChangePlaybackRate"
/// 更改放缩比例
public let kMsgNameChangeScalingMode = "kMsgNameChangeScalingMode"
/// 截图
public let kMsgNameShotScreen = "kMsgNameShotScreen"
/// 添加播放器view到视图
public let kMsgNameAddPlayerView = "kMsgNameAddPlayerView"
/// 播放器播放进度更新
public let kMsgNamePlaybackTimeUpdate = "kMsgNamePlaybackTimeUpdate"
/// 快进、快退失败
public let kMsgNamePlayerSeekFailed = "kMsgNamePlayerSeekFailed"
/// 快进、快退
public let kMsgNamePlayerSeeking = "kMsgNamePlayerSeeking"
/// 快进、快退结束
public let kMsgNamePlayerSeekEnded = "kMsgNamePlayerSeekEnded"

///  展示loading动画
public let kMsgNameStartLoading = "kMsgNameStartLoading"
/// 结束loading动画
public let kMsgNameEndLoading = "kMsgNameEndLoading"



// ------------- Event Name -------------
/// 切换全屏半屏
public let kEventNameFullScrennAction = "kEventNameFullScrennAction"
/// 返回
public let kEventNameBackAction = "kEventNameBackAction"
/// 播放暂停
public let kEventNamePlayAction = "kEventNamePlayAction"
/// 更多
public let kEventNameMoreAction = "kEventNameMoreAction"
/// 切换速率
public let kEventNamePlayRateAction = "kEventNamePlayRateAction"
/// 切换速率
public let kEventNameSwitchQuality = "kEventNameSwitchQuality"
/// 分享
public let kEventNameShareAction = "kEventNameShareAction"
/// next
public let kEventNameNextAction = "kEventNameNextAction"
/// 截屏
public let kEventNameScreenShotAction = "kEventNameScreenShotAction"
/// 录像
public let kEventNameRecordingAction = "kEventNameRecordingAction"
/// 锁屏
public let kEventNameLockScreenAction = "kEventNameLockScreenAction"
/// 音量
public let kEventNameVolumeAction = "kEventNameVolumeAction"
/// 亮度
public let kEventNameBrightLightAction = "kEventNameBrightLightAction"


/// 切换语音和文本输入
public let kEventNameVoiceTouchDragInside = "kEventNameVoiceTouchDragInside"
/// 切换语音和文本输入
public let kEventNameVoiceTouchDragOutside = "kEventNameVoiceTouchDragOutside"
/// 更多键盘点击
public let kEventNameVoiceTouchUpInside = "kEventNameVoiceTouchUpInside"
/// 点击确定发送消息
public let kEventNameVoiceTouchUpOutside = "kEventNameVoiceTouchUpOutside"
/// 点击图片消息消息
public let kEventNameDidSelectImage = "kEventNameDidSelectImage"
/// 点击图文混合消息
public let kEventNameDidSelectImageAndText = "kEventNameDidSelectImageAndText"


/// 弹出文本键盘
public let kEventNameKeyboardWeakup = "kEventNameKeyboardWeakup"
/// 更新群组
public let kEventNameTeamsUpdate = "kEventNameTeamsUpdate"
/// 发送失败重新发送消息
public let kEventNameSendMsgRetry = "kEventNameSendMsgRetry"
// 授权获取电话号码
public let kEventNameRequestPhoneNumber = "kEventNameRequestPhoneNumber"
/// 相机📷获取图片
public let kEventNameUploadImageCerame = "kEventNameUploadImageCerame"
/// 相册获取图片
public let kEventNameUploadImageLibary = "kEventNameUploadImageLibary"
/// 群组设置删除群组成员
public let kEventNameGroup_delete_user = "kEventNameGroup_delete_user"
/// 更新自有ID
public let kMsgNameUpdateCharID = "kMsgNameUpdateCharID"
/// 开始播放视频
public let kEventNameStartPlayDemoVideo = "kEventNameStartPlayDemoVideo"
/// 暂停播放视频
public let kEventNamePausePlayDemoVideo = "kEventNamePausePlayDemoVideo"
/// 结束播放视频
public let kEventNameStopPlayDemoVideo = "kEventNameStopPlayDemoVideo"
