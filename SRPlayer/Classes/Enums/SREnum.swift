//
//  SREnum.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public enum SpeedType {
    case recv
    case sent
    case all
    
    // wifi和wwan只能使用一个上面能表示所以情况
    var name: String {
        switch self {
        case .recv:
            return "下载速度"
        case .sent:
            return "上传速度"
        case .all:
            return "当前总速度"
        }
    }
}

public enum ConnectType {
    case wifi
    case wwan
    case unknow
    
    var name: String {
        switch self {
        case .wifi:
            return "Wi-Fi"
        case .wwan:
            return "蜂窝网络"
        case .unknow:
            return "无网络"
        }
    }
}

/** 播放器层枚举 */
public enum PlayerUnit {
    case player   // 播放器层
    case bkground  // 背景层
    case barrage  // 弹幕层
    case float // 悬浮控件
    case edgeArea  // 边缘区域层
    case moreArea // 更多
    case maskArea // 遮罩层
}

// 手势状态状态
public enum GestureState {
    case begin
    case change(CGFloat)
    case end
    case cancle
}

public enum EdgeAreaUnit {
    case left   // 左侧
    case right  // 右侧
    case top  // 顶部
    case bottom // 底部
}

// 屏幕手势事件
public enum GestureUnit {
    case pan           // 垂直 & 水平 拖动 [vertLeftPan, vertRightPan, horiPan]
    case vertLeftPan   // 左侧垂直拖动
    case vertRightPan  // 右侧垂直拖动
    case horiPan       // 水平拖动
    case singleClick       // 单击
    case doubleClick       // 双击
    case longPress         // 长按
}

// 滑动方向
public enum PanDirection {
    case horizontal // 横向移动
    case vertical  // 纵向移动
    case left      // 纵向移动时在左侧
    case right     // 纵向移动时在右侧
}

// 布局方向
public enum Direction {
    case clockwise            //顺时针约束 | --> 根据最左侧view布局，布局优先级高
    case anticlockwis         //逆时针 <-- | 根据最右侧view布局，布局优先级高
    case stretchable          //剩余空间两端约束  <- | -> 根据左侧、右侧view布局，布局优先级最低
}

// 布局方向
public enum Location {
    case top      // 顺时针约束
    case bottom   // 剩余空间两端约束
    case left          //
    case right         // 左右都是从中心开始
}

// item状态
public enum ItemState {
    case normal
    case willbegin
    case doing
    case completion
    case failed
}

// item类型
public enum ItemStyle: String {
    // top
    case back = "kEventNameBackAction" // 返回
    case title = "kEventNameTitleAction" // 标题
    case share = "kEventNameShareAction"// 分享
    case more = "kEventNameMoreAction"// 更多
    case mirro = "kEventNameMirroAction"// 镜像
    case scale = "kEventNameScaleModeAction"// 模式
    
    // bottom
    case play = "kEventNamePlayAction"// 播放、暂停
    case curTime = "kEventNameCurrTimeAction"// 当前时间
    case next = "kEventNameNextAction"// 下一集
    case tolTime = "kEventNameTolTimeAction"// 总时间
    case slider = "kEventNameSliderAction"// 播放进度
    case sharpness = "kEventNameSharpnessAction"// 亮度
    case playRate  = "kEventNamePlayRateAction"// 倍数
    case series  = "kEventNamePlaySeriesAction"// 剧集
    case resolve  = "kEventNamePlayResolveAction"// 清晰度
    case fullScrenn  = "kEventNameFullScrennAction"// 全屏
    case volume  = "kEventNameVolumeAction"// 音量
    case brightLight  = "kEventNameBrightLightAction"// 亮度
    case living = "kEventNameBrightLivingAction"// 直播
    
    // right
    case screenShot = "kEventNameScreenShotAction"// 截屏
    case recording = "kEventNameRecordingAction"// 录像

    // left
    case lockScreen = "kEventNameLockScreenAction"// 锁屏
    
    var image: String {
        switch self {
        case .back:
            return "sr_back"
        case .title:
            return ""
        case .share:
            return "sr_share"
        case .more:
            return "sr_more"
        case .mirro:
            return "sr_mirror"
        case .scale:
            return "sr_scare_big"
        case .play:
            return "sr_play"
        case .curTime:
            return ""
        case .next:
            return "sr_next"
        case .tolTime:
            return ""
        case .slider:
            return ""
        case .sharpness:
            return ""
        case .playRate:
            return ""
        case .series:
            return ""
        case .resolve:
            return ""
        case .fullScrenn:
            return "sr_fullscreen"
        case .volume:
            return ""
        case .brightLight:
            return ""
        case .living:
            return "sr_living"
        case .screenShot:
            return "sr_capture"
        case .recording:
            return ""
        case .lockScreen:
            return "sr_unlock"
        }
    }
}
