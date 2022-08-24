//
//  SRProtocol.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import SnapKit

/// MARK: -- 空协议
public protocol Command { }

/// MARK: -- 透传协议
public protocol SRPierce {
    /** 是否支持事件穿透*/
    var canPierce: Bool { get set }
}

/// MARK: -- 背景层协议
public protocol SRBackground: UIView {

}

/// MARK: -- 弹幕层协议
public protocol SRBarrage: UIView {
    
}

/// MARK: -- 浮动层协议
public protocol SRFloat_P: UIView {
    var toasts: [Toast] { get }
    var units: [ToastType] { get set }
    func showUnit(units: [ToastType], visible: Bool)
}

/// MARK: -- 遮罩层协议
public protocol SRMask: UIView {
    
}
