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
/// 开始播放
public let kMsgNameStartPlay = "kMsgNameStartPlay"
/// 停止播放
public let kMsgNameStopPlay = "kMsgNameStopPlay"
/// 暂停播放
public let kMsgNamePausePlay = "kMsgNamePausePlay"
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
/// 准备播放
public let kMsgNamePrepareToPlay = "kMsgNamePrepareToPlay"
/// 播放器播放进度更新
public let kMsgNamePlaybackTimeUpdate = "kMsgNamePlaybackTimeUpdate"
/// 快进、快退失败
public let kMsgNamePlayerSeekFailed = "kMsgNamePlayerSeekFailed"
/// 快进、快退
public let kMsgNamePlayerSeeking = "kMsgNamePlayerSeeking"
/// 快进、快退结束
public let kMsgNamePlayerSeekEnded = "kMsgNamePlayerSeekEnded"
/// 切换全屏半屏
public let kEventNameFullScrennAction = "kEventNameFullScrennAction"
/// 返回
public let kEventNameBackAction = "kEventNameBackAction"

/// 切换语音和文本输入
public let kMsgNameSwitchTextMoreKeyBoard = "kMsgNameSwitchTextMoreKeyBoard"
/// 更多键盘点击
public let kEventNameMoreKeyBoardAction = "kEventNameMoreKeyBoardAction"
/// 点击确定发送消息
public let kEventNameKeyBoardSendMsg = "kEventNameKeyBoardSendMsg"
/// 开始录音
public let kMsgNameStartRecording = "kMsgNameStartRecording"
/// 停止录音
public let kMsgNameStopRecording = "kMsgNameStopRecording"
/// 取消录音
public let kMsgNameCancleRecording = "kMsgNameCancleRecording"
/// 语音消息错误
public let kMsgNameRecordVoiceError = "kMsgNameRecordVoiceError"
/// 说话时间太短
public let kMsgNameRecordVoiceSpeakShort = "kMsgNameRecordVoiceSpeakShort"
/// 说话时间太长
public let kMsgNameRecordVoiceSpeakLong = "kMsgNameRecordVoiceSpeakLong"
/// 更新音量
public let kMsgNameRecordUpdatePower = "kMsgNameRecordUpdatePower"
/// 语音消息
public let kEventNameVoiceTouchDown = "kEventNameVoiceTouchDown"
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

// ------------- Event Name -------------

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
/// 开始播放音频
public let kEventNameStartPlayAudio = "kEventNameStartPlayAudio"
/// 结束播放音频
public let kEventNameStopPlayAudio = "kEventNameStopPlayAudio"
