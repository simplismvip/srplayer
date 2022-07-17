
import Foundation

// ------------- Msg Name -------------

/// 发送文本消息
let kMsgNameSendTextMessage = "kMsgNameSendTextMessage"
/// 发送语音消息
let kMsgNameSendVoiceMessage = "kMsgNameSendVoiceMessage"
/// 发送图文混合消息
let kMsgNameSendImageAndTextMessage = "kMsgNameSendImageAndTextMessage"
/// 发送图片消息
let kMsgNameSendImageMessage = "kMsgNameSendImageMessage"
/// 发送位置消息
let kMsgNameSendLocationMessage = "kMsgNameSendLocationMessage"
/// 接收到的消息
let kMsgNameReciveMessage = "kMsgNameReciveMessage"
/// 发送消息进度
let kMsgNameSendUpdateProgress = "kMsgNameSendUpdateProgress"
/// 发送消息失败
let kMsgNameSendMessageFails = "kMsgNameSendMessageFails"
/// 发送发送错误
let kMsgNameSendMessageError = "kMsgNameSendMessageError"
/// 发送消息完成
let kMsgNameSendMessageCompletion = "kMsgNameSendMessageCompletion"
/// 开始发送消息
let kMsgNameSendMessageStart = "kMsgNameSendMessageStart"
/// 收到消息已读回执
let kMsgNameHavedReadMessage = "kMsgNameHavedReadMessage"
/// 收到消息撤回回执
let kMsgNameRevokeMessage = "kMsgNameRevokeMessage"
/// 展示键盘
let kMsgNameKeyBoardShow = "kMsgNameKeyBoardShow"
/// 回收键盘
let kMsgNameKeyBoardHide = "kMsgNameKeyBoardHide"
/// 更新输入框高度
let kMsgNameKeyBoardUpdateHeight = "kMsgNameKeyBoardUpdateHeight"
/// 切换语音和文本输入
let kMsgNameSwitchTextVoiceKeyBoard = "kMsgNameSwitchTextVoiceKeyBoard"
/// 切换语音和文本输入
let kMsgNameSwitchTextMoreKeyBoard = "kMsgNameSwitchTextMoreKeyBoard"
/// 更多键盘点击
let kEventNameMoreKeyBoardAction = "kEventNameMoreKeyBoardAction"
/// 点击确定发送消息
let kEventNameKeyBoardSendMsg = "kEventNameKeyBoardSendMsg"
/// 开始录音
let kMsgNameStartRecording = "kMsgNameStartRecording"
/// 停止录音
let kMsgNameStopRecording = "kMsgNameStopRecording"
/// 取消录音
let kMsgNameCancleRecording = "kMsgNameCancleRecording"
/// 语音消息错误
let kMsgNameRecordVoiceError = "kMsgNameRecordVoiceError"
/// 说话时间太短
let kMsgNameRecordVoiceSpeakShort = "kMsgNameRecordVoiceSpeakShort"
/// 说话时间太长
let kMsgNameRecordVoiceSpeakLong = "kMsgNameRecordVoiceSpeakLong"
/// 更新音量
let kMsgNameRecordUpdatePower = "kMsgNameRecordUpdatePower"
/// 语音消息
let kEventNameVoiceTouchDown = "kEventNameVoiceTouchDown"
/// 切换语音和文本输入
let kEventNameVoiceTouchDragInside = "kEventNameVoiceTouchDragInside"
/// 切换语音和文本输入
let kEventNameVoiceTouchDragOutside = "kEventNameVoiceTouchDragOutside"
/// 更多键盘点击
let kEventNameVoiceTouchUpInside = "kEventNameVoiceTouchUpInside"
/// 点击确定发送消息
let kEventNameVoiceTouchUpOutside = "kEventNameVoiceTouchUpOutside"
/// 点击图片消息消息
let kEventNameDidSelectImage = "kEventNameDidSelectImage"
/// 点击图文混合消息
let kEventNameDidSelectImageAndText = "kEventNameDidSelectImageAndText"

// ------------- Event Name -------------

/// 弹出文本键盘
let kEventNameKeyboardWeakup = "kEventNameKeyboardWeakup"
/// 更新群组
let kEventNameTeamsUpdate = "kEventNameTeamsUpdate"
/// 发送失败重新发送消息
let kEventNameSendMsgRetry = "kEventNameSendMsgRetry"
// 授权获取电话号码
let kEventNameRequestPhoneNumber = "kEventNameRequestPhoneNumber"
/// 相机📷获取图片
let kEventNameUploadImageCerame = "kEventNameUploadImageCerame"
/// 相册获取图片
let kEventNameUploadImageLibary = "kEventNameUploadImageLibary"
/// 群组设置删除群组成员
let kEventNameGroup_delete_user = "kEventNameGroup_delete_user"
/// 更新自有ID
let kMsgNameUpdateCharID = "kMsgNameUpdateCharID"
/// 开始播放音频
let kEventNameStartPlayAudio = "kEventNameStartPlayAudio"
/// 结束播放音频
let kEventNameStopPlayAudio = "kEventNameStopPlayAudio"
