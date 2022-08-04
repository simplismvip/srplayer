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
public protocol SRPlayerGesture: NSObject {
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
    var activityEvents: [GestureUnit] { get }
    /** 手势协议*/
    var delegate: SRPlayerGesture? { set get }
    /** 激活事件*/
    func activeEvents(_ events: [GestureUnit])
    /** 关闭事件*/
    func deactiveEvents(_ events: [GestureUnit])
    /** 判断events是否可响应*/
    func eventsActivity(_ event: GestureUnit) -> Bool
}

/// MARK: -- 背景层协议
public protocol SRBackground: UIView {
//    var currentColor: UIColor { get }
//    var alpha: CGFloat { get }
}

/// MARK: -- 弹幕层协议
public protocol SRBarrage: UIView {
    
}

/// MARK: -- 浮动层协议
public protocol SRFloat_P: UIView {
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
    public func current(_ type: EdgeAreaUnit) -> UIView {
        switch type {
        case .top:
            return top
        case .left:
            return self.left
        case .bottom:
            return bottom
        case .right:
            return self.right
        }
    }
}

extension SREdgeArea {
    /** 显示/隐藏 子区域视图 */
    public func visibleUnit(units: [EdgeAreaUnit], visible: Bool, completion: SRFinish?) {
        UIView.animate(withDuration: 0.3) {
            units.forEach { unit in
                self.current(unit).alpha = visible ? 1 : 0
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
//    /** More容器视图*/
//    var moreContainer: UIView { get }
//    /** More 显示/隐藏 动画hock*/
//    var visibleAnimate: SRVisible { get }
//    /**显示/隐藏 More容器*/
//    func visibleMore(visible: Bool, animation: Bool, completion: @escaping SRFinish)
}

/// MARK: -- 遮罩层协议
public protocol SRMask: UIView {
    
}

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

/// MARK: -- 控制协议
public protocol CotrolProtocol {
    associatedtype ContentView: SRContent
    /** 添加PlayerFrame层内容视图*/
    var view: ContentView { get }
    /** 添加PlayerFrame层内容视图*/
    var processM: SRProgressManager { get }
    /** 添加PlayerFrame层内容视图*/
    var barManager: SRBarManager { get }
    /*显示更多区域*/
    func showMoreArea(width: CGFloat, animation: Bool)
    /*隐藏更多区域*/
    func hideMoreArea(animation: Bool)
    /*
     显示Edge 子区域
     unit: 子区域集合
     */
    func showEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool)
    /*
     隐藏Edge 子区域
     unit: 子区域集合
     */
    func hideEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool)
}

extension CotrolProtocol {
    public func add(subview: UIView, content: UIView, layout: SRLayout) {
        subview.superview?.removeFromSuperview()
        remove(content)
        
        content.addSubview(subview)
        subview.snp.makeConstraints { make in
            layout(make, content)
        }
        
        content.setNeedsLayout()
        content.layoutIfNeeded()
    }
    
    public func remove(_ content: UIView) {
        content.removellSubviews { _ in true }
    }
    
    // 添加图层子视图
    public func addSubview(_ subview: UIView, unit: PlayerUnit) {
        let content = self.view.current(unit: unit)
        add(subview: subview, content: content) { make, view in
            make.edges.equalTo(view)
        }
    }
    
    // 移除图层子视图
    public func removeSubview(_ unit: PlayerUnit) {
        let content = self.view.current(unit: unit)
        remove(content)
        content.removeFromSuperview()
    }
    
    // 添加Edge区域
    public func addEdgeArea(_ unit: EdgeAreaUnit) {
        let subview = self.barManager.current(unit)
        let content = self.view.edgeAreaView.current(unit)
        add(subview: subview, content: content) { make, view in
            make.edges.equalTo(view)
        }
    }
    
    // 移除Edge区域
    public func removeEdgeArea(_ unit: EdgeAreaUnit) {
        let content = self.view.edgeAreaView.current(unit)
        remove(content)
    }
}
