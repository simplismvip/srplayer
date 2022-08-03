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
public protocol SRPlayer_P: UIView {
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
public protocol SRBkg_P: UIView {
    var currentColor: UIColor { get }
    var alpha: CGFloat { get }
}

/// MARK: -- 弹幕层协议
public protocol SRBarrage: UIView {
    
}

/// MARK: -- 浮动层协议
public protocol SRFloat_P {
    var loading: SRLoading { get }
}

extension SRFloat_P {
    
    public func startLoading() {
        loading.start()
        loading.isHidden = false
    }
    
    public func stopLoading() {
        loading.stop()
        loading.isHidden = true
    }
}

/// MARK: -- 边缘层协议
public protocol SREdgeArea: UIView {
    associatedtype View: SRPierce & UIView
    /** top容器视图*/
    var top: View { get }
    /** left容器视图*/
    var left: View { get }
    /** right容器视图*/
    var right: View { get }
    /** bottom容器视图*/
    var bottom: View { get }
    /** 当前区域 */
    var units: [EdgeAreaUnit] { get set }
}

extension SREdgeArea {
    /** 显示/隐藏 子区域视图 */
    public func visibleUnit(units: [EdgeAreaUnit], visible: Bool, completion: SRFinish?) {
        UIView.animate(withDuration: 0.3) {
            units.forEach { unit in
                if unit == .top {
                    self.top.alpha = visible ? 1 : 0
                }
                
                if unit == .left {
                    self.left.alpha = visible ? 1 : 0
                }
                
                if unit == .right {
                    self.right.alpha = visible ? 1 : 0
                }
                
                if unit == .bottom {
                    self.bottom.alpha = visible ? 1 : 0
                }
            }
        } completion: { finsh in
            completion?()
        }
    }
    
    /** 获取子区域是否显示*/
    public func unitVisible(_ unit: EdgeAreaUnit) -> Bool {
        return units.contains { unit == $0 }
    }
}

/// MARK: -- 更多层协议
public protocol SRMoreArea: UIView {
    /** More容器视图*/
    var moreContainer: UIView { get }
    /** More 显示/隐藏 动画hock*/
    var visibleAnimate: SRVisible { get }
    /**显示/隐藏 More容器*/
    func visibleMore(visible: Bool, animation: Bool, completion: @escaping SRFinish)
}

/// MARK: -- 遮罩层协议
public protocol SRMask: UIView {
    
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
    /** more区域视图是否出现*/
    var moreAreaVisible: Bool { get }
    
    /** 添加PlayerFrame层内容视图*/
    func addPlayer(_ content: UIView)
    /** 移除PlayerFrame层内容视图*/
    func removePlayerContent()

    /** 添加Background层内容视图*/
    func addBackground(_ content: UIView)
    /** 移除Background层内容视图*/
    func removeBackground()

    /** 添加Barrage层内容视图*/
    func addBarrage(_ content: UIView)
    /** 移除Barrage层内容视图*/
    func removeBarrage()
    
    /** 添加MoreArea moreContainer层内容视图*/
    func addMoreArea(_ content: UIView)
    /** 移除MoreArea moreContainer 层内容视图*/
    func removeMoreArea()

    /** 添加Mask 层内容视图*/
    func addMask(_ content: UIView)
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

extension CotrolProtocol {
    public func addFill(content: UIView, player: UIView, layout: SRLayout) {
        content.superview?.removeFromSuperview()
        removeFill(player)
        
        player.addSubview(content)
        content.snp.makeConstraints { make in
            layout(make, player)
        }
        
        player.setNeedsLayout()
        player.layoutIfNeeded()
    }
    
    public  func removeFill(_ player: UIView) {
        for subview in player.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func addSubview(_ subview: UIView) {
//        addFill(content: subview, player: self.view.playerView) { make, view in
//            make.edges.equalTo(view)
//        }
    }
    
    func removeSubview() {
        
    }
}
