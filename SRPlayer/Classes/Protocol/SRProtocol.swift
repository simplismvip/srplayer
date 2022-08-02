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

/// MARK: -- 播放手势协议
public protocol SRPlayerGesture {
    /** 左侧垂直方向 开始拖动*/
    func panBeginLeftVertical(_ player: UIView)
    /** 左侧垂直方向 正在拖动*/
    func panMoveLeftVertical(player: UIView, offsetValue: CGFloat)
    /** 左侧垂直方向 结束拖动*/
    func panEndedLeftVertical(_ player: UIView)
    /** 左侧垂直方向 取消拖动*/
    func panCancelledLeftVertical(_ player: UIView)
    /** 右侧垂直方向 开始拖动*/
    func panBeginRightVertical(_ player: UIView)
    /** 右侧垂直方向 正在拖动*/
    func panMoveRightVertical(player: UIView, offsetValue: CGFloat)
    /** 右侧垂直方向 结束拖动*/
    func panEndedRightVertical(_ player: UIView)
    /** 右侧垂直方向 取消拖动*/
    func panCancelledRightVertical(_ player: UIView)
    /** 水平方向 开始拖动*/
    func panBeginHorizontal(_ player: UIView)
    /** 水平方向 正在拖动*/
    func panMoveHorizontal(player: UIView, offsetValue: CGFloat)
    /** 水平方向 结束拖动*/
    func panEndedHorizontal(_ player: UIView)
    /** 水平方向 取消拖动*/
    func panCancelledHorizontal(_ player: UIView)
    /** 单击*/
    func click(_ player: UIView)
    /** 双击*/
    func doubleClick(_ player: UIView)
    /** 长按 **/
    func longPress(player: UIView)
}

/// MARK: -- 播放手势协议
public protocol SRPlayer_P {
    /** 可响应的events*/
    var activityEvents: [PlayerEventUnit] { get }
    /** 手势协议*/
    var delegate: SRPlayerGesture? { set get }
    /** 激活事件*/
    func activeEvents(_ events: [PlayerEventUnit])
    /** 关闭事件*/
    func deactiveEvents(_ events: [PlayerEventUnit])
    /** 判断events是否可响应*/
    func eventsActivity(_ event: PlayerEventUnit) -> Bool
}

/// MARK: -- 背景层协议
public protocol SRBkg_P {
    var currentColor: UIColor { get }
    var alpha: CGFloat { get }
}

/// MARK: -- 弹幕层协议
public protocol SRBarrage {
    
}

/// MARK: -- 浮动层协议
public protocol SRFloat_P {
    
}

/// MARK: -- 边缘层协议
public protocol SREdgeArea {
    associatedtype View: SRPierce
    /** top容器视图*/
    var top: View { get }
    /** left容器视图*/
    var left: View { get }
    /** right容器视图*/
    var right: View { get }
    /** bottom容器视图*/
    var bottom: View { get }
    /** 可见子区域 */
    var visibleUnits: [EdgeAreaUnit] { get set }
    
    /** 子区域显示动画hock*/
    var visibleAnimate: SREdgeVisible { get }
    /** 显示/隐藏 子区域视图 */
    func visibleUnit(units: [EdgeAreaUnit], visible: Bool, animation: Bool)
    func visibleUnit(units: [EdgeAreaUnit], visible: Bool, animation: Bool, completion: @escaping SRFinish)
    /** 获取子区域是否显示*/
    func subAreaUnitCurrentDisplayed(unit: EdgeAreaUnit) -> Bool
}

/// MARK: -- 更多层协议
public protocol SRMoreArea {
    /** More容器视图*/
    var moreContainer: UIView { get }
    /** More 显示/隐藏 动画hock*/
    var visibleAnimate: SRVisible { get }
    /**显示/隐藏 More容器*/
    func visibleMore(visible: Bool, animation: Bool, completion: @escaping SRFinish)
}

/// MARK: -- 遮罩层协议
public protocol SRMask {
    
}

/// MARK: -- 容器层协议
public protocol SRBaseContainer {
    associatedtype PlayerView//: SRPlayer_P
    associatedtype BKGView//: SRBkg_P
    associatedtype BarrageView: SRBarrage
    associatedtype FloatView: SRFloat_P
    associatedtype EdgeAreaView: SREdgeArea
    associatedtype MoreAreaView//: SRMoreArea
    associatedtype MaskView: SRMask
    
    /** 播放器层 */
    var playerView: PlayerView { get }
    /** 背景层 */
    var bkgView: BKGView { get }
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

/// MARK: -- 控制协议
public protocol CotrolProtocol {
    associatedtype BKContainer: SRBaseContainer
    /** 添加PlayerFrame层内容视图*/
    var view: BKContainer { get }
    /** 边缘可见子区域*/
    var edgeVisibleUnit: EdgeAreaUnit { get set}
    /** more区域视图是否出现*/
    var moreAreaVisible: Bool { get }
    /** more区域动画执行hock */
    var edgeVisibleAnimate: (_ visible: Bool, _ unit: EdgeAreaUnit) -> Void { get }
    /** edge区域动画执行hock*/
    var moreVisibleAnimate: SRVisible { get }
    
    /** 添加PlayerFrame层内容视图*/
    func addPlayer(_ content: UIView)
    func addPlayer(_ content: UIView, layout: SRLayout)
    /** 移除PlayerFrame层内容视图*/
    func removePlayerContent()

    /** 添加Background层内容视图*/
    func addBackground(_ content: UIView)
    func addBackground(_ content: UIView, layout: SRLayout)
    /** 移除Background层内容视图*/
    func removeBackground()

    /** 添加Barrage层内容视图*/
    func addBarrage(_ content: UIView)
    func addBarrage(_ content: UIView, layout: SRLayout)
    /** 移除Barrage层内容视图*/
    func removeBarrage()

    /** 添加EdgeArea Top 层内容视图*/
    func addEdgeAreaTop(_ content: UIView)
    func addEdgeAreaTop(_ content: UIView, layout: SRLayout)
    /** 移除EdgeArea Top 层内容视图*/
    func removeEdgeAreaTop()

    /** 添加EdgeArea Left 层内容视图*/
    func addEdgeAreaLeft(_ content: UIView)
    func addEdgeAreaLeftContent(_ content: UIView, layout: SRLayout)
    /** 移除EdgeArea Left 层内容视图*/
    func removeEdgeAreaLeft()

    /** 添加EdgeArea Right 层内容视图*/
    func addEdgeAreaRight(_ content: UIView)
    func addEdgeAreaRight(_ content: UIView, layout: SRLayout)
    /** 移除EdgeArea Right 层内容视图*/
    func removeEdgeAreaRight()

    /** 添加EdgeArea Bottom 层内容视图*/
    func addEdgeAreaBottom(_ content: UIView)
    func addEdgeAreaBottom(_ content: UIView, layout: SRLayout)
    /** 移除EdgeArea Bottom 层内容视图*/
    func removeEdgeAreaBottom()

    /** 添加MoreArea moreContainer层内容视图*/
    func addMoreArea(_ content: UIView)
    func addMoreArea(_ content: UIView, layout: SRLayout)
    /** 移除MoreArea moreContainer 层内容视图*/
    func removeMoreArea()

    /** 添加Mask 层内容视图*/
    func addMask(_ content: UIView)
    func addMask(_ content: UIView, layout: SRLayout)
    /** 移除Mask 层内容视图*/
    func removeMask()

    /** 添加Float 层子视图*/
    func addFloat(_ content: UIView)
    /** 移除Float 层子视图 */
    func removeFloat(_ content: UIView);

    /*显示更多区域*/
    func showMoreArea(width: CGFloat, animation: Bool)
    func showMoreArea(width: CGFloat, animation: Bool, completion: @escaping SRFinish)
    /*隐藏更多区域*/
    func hideMoreArea(animation: Bool)
    func hideMoreArea(animation: Bool, completion: @escaping SRFinish)

    /*
     显示Edge 子区域
     unit: 子区域集合
     */
    func showEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool)
    func showEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool, completion: @escaping SRFinish)
    /*
     隐藏Edge 子区域
     unit: 子区域集合
     */
    func hideEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool)
    func hideEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool, completion: @escaping SRFinish)
}
