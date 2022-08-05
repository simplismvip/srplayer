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
    /** 可响应的events*/
    var activityEvents: [GestureUnit] { get }
    /** 手势协议*/
    var delegate: SRPlayerGesture? { set get }
    /** 激活事件*/
    func enableEvents(_ events: [GestureUnit], enabled: Bool)
    /** 判断events是否可响应*/
    func eventsActivity(_ event: GestureUnit) -> Bool
}

/// MARK: -- 背景层协议
public protocol SRBackground: UIView {

}

/// MARK: -- 弹幕层协议
public protocol SRBarrage: UIView {
    
}

/// MARK: -- 浮动层协议
public protocol SRFloat_P: UIView {

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
    var content: UIView { get }
    var type: MoreEdgeType { set get }
}

extension SRMoreArea {
    /// 显示/隐藏 More容器
    public func visibleMore(_ visible: Bool, animation: Bool) {
        let offset = visible ? 0 : self.content.jmWidth
        UIView.animate(withDuration: 0.5) {
            self.content.snp.makeConstraints { make in
                make.right.equalTo(self).offset(offset)
            }
        } completion: { finish in
            self.content.isHidden = !visible
        }
    }
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
