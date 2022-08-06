//
//  PlayerGesture.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/6.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

/// MARK: -- 播放手势协议
public protocol SRPlayerGesture: NSObject {
    /** 左侧垂直滑动手势 */
    func panLeftVertical(_ player: UIView, state: GestureState)
    /** 右侧垂直滑动手势  */
    func panRightVertical(_ player: UIView, state: GestureState)
    /** 水平滑动手势 */
    func panHorizontal(_ player: UIView, state: GestureState)
    /** 单击*/
    func singleClick()
    /** 双击*/
    func doubleClick()
    /** 长按 **/
    func longPress(_ state: GestureState)
}

/// MARK: -- 播放手势协议
public protocol SRPlayer_P: UIView {
    /// 可响应的events
    var activityEvents: [GestureUnit] { get }
    /// 手势协议
    var delegate: SRPlayerGesture? { get }
    /// 激活事件
    func enableEvents(_ events: [GestureUnit], enabled: Bool)
}

extension SRPlayer_P {
    /// 判断events是否可响应
    public func eventsActivity(_ event: GestureUnit) -> Bool {
        return activityEvents.contains(event)
    }
}
