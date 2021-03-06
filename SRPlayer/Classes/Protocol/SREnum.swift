//
//  SREnum.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public enum EdgeAreaUnit {
    case left   // 左侧
    case right  // 右侧
    case top  // 顶部
    case bottom // 底部
    case all    // 所有
}

public enum ControlBarType {
    case left   // 左侧
    case right  // 右侧
    case top  // 顶部
    case bottom // 底部
}

// 屏幕手势事件
public enum PlayerEventUnit {
    case vertLeftPan   // 左侧垂直拖动
    case vertRightPan  // 右侧垂直拖动
    case horiPan      // 水平拖动
    case pan        // 垂直 & 水平 拖动 [vertLeftPan, vertRightPan, horiPan]
    case singleClick       // 单击
    case doubleClick       // 双击
    case pinch             // 捏合
    // case all               // 所有事件 [vertLeftPan, vertRightPan, horiPan, singleClick, doubleClick, pinch]
    
//    static var allEvents: [PlayerEventUnit] {
//        return [.vertLeftPan, .vertRightPan, .horiPan, .singleClick, .doubleClick, .pinch]
//    }
//    
//    static var vL_vR_horPan: [PlayerEventUnit] {
//        return [.vertLeftPan, .vertRightPan, .horiPan]
//    }
}

// 滑动方向
public enum PanDirection {
    case horizontal // 横向移动
    case vertical  // 纵向移动
    case left      // 纵向移动时在左侧
    case right     // 纵向移动时在右侧
}

// 布局方向
public enum LayoutDirection {
    case clockwise            //顺时针约束
    case anticlockwis         //逆时针
    case stretchable          //剩余空间两端约束
    case centerOfSpare        //剩余空间中间约束
    case centerOfView         //视图中心约束
}

// 布局方向
public enum LayoutLocation {
    case top_left      // 顺时针约束
    case top_right     // 逆时针
    case top_center     // 逆时针
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
    
    // bottom
    case play = "kEventNamePlayAction"// 播放、暂停
    case curTime = "kEventNameCurrTimeAction"// 当前时间
    case next = "kEventNameNextAction"// 下一集
    case tolTime = "kEventNameTolTimeAction"// 总时间
    case slider = "kEventNameSliderAction"// 播放进度
    case sharpness = "kEventNameSharpnessAction"// 清晰度
    case playRate  = "kEventNamePlayRateAction"// 倍数
    case fullScrenn  = "kEventNameFullScrennAction"// 全屏
    case volume  = "kEventNameVolumeAction"// 音量
    case brightLight  = "kEventNameBrightLightAction"// 亮度
    
    // right
    case screenShot = "kEventNameScreenShotAction"// 截屏
    case recording = "kEventNameRecordingAction"// 录像

    // left
    case lockScreen = "kEventNameLockScreenAction"// 锁屏
    
    // empty
    case empty = "kEventNameLockEmptyAction"
}
