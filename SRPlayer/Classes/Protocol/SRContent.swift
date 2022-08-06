//
//  SRContent.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/6.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

/// MARK: -- 容器层协议
public protocol SRContent {
    associatedtype PlayerView: SRPlayer_P
    associatedtype BackgroundView: SRBackground
    associatedtype BarrageView: SRBarrage
    associatedtype FloatView: SRFloat_P
    associatedtype EdgeAreaView: SREdgeArea
    associatedtype MoreAreaView: SRMoreArea
    associatedtype MaskView: SRMask
    
    /** 播放器层 */
    var playerView: PlayerView { get }
    /** 背景层 */
    var bkgView: BackgroundView { get }
    /** 弹幕层（预留） */
    var barrageView: BarrageView { get }
    /** 悬浮控件 */
    var floatView: FloatView { get }
    /** 边缘区域层 */
    var edgeAreaView: EdgeAreaView { get }
    /** 更多 */
    var moreAreaView: MoreAreaView { get }
    /** 遮罩层 */
    var maskAreaView: MaskView { get }
}

extension SRContent {
    public func current(unit: PlayerUnit) -> UIView {
        switch unit {
        case .player:
            return playerView
        case .bkground:
            return bkgView
        case .barrage:
            return barrageView
        case .float:
            return floatView
        case .edgeArea:
            return edgeAreaView
        case .moreArea:
            return moreAreaView
        case .maskArea:
            return maskAreaView
        }
    }
}

