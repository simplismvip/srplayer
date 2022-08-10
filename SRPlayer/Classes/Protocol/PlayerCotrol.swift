//
//  CotrolProtocol.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/6.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

/// MARK: -- 控制协议
public protocol PlayerCotrol {
    associatedtype ContentView: SRContent
    /** 添加PlayerFrame层内容视图*/
    var view: ContentView { get }
    /** 添加PlayerFrame层内容视图*/
    var flowManager: SRFlowManager { get }
    /** 添加PlayerFrame层内容视图*/
    var barManager: SRBarManager { get }
}

extension PlayerCotrol {
    /// 显示更多区域
    public func showMoreArea(_ type: MoreEdgeType) {
        view.moreAreaView.begin(type)
        view.edgeAreaView.showUnit(units: [.left, .right, .top, .bottom], visible: false)
        view.playerView.enableEvents([.longPress, .doubleClick, .pan], enabled: false)
        view.moreAreaView.update(true)
    }
    /// 隐藏更多区域
    public func hideMoreArea() {
        view.moreAreaView.update(false)
        view.edgeAreaView.showUnit(units: [.left, .right, .top, .bottom], visible: true)
        view.playerView.enableEvents([.longPress, .doubleClick, .pan], enabled: true)
    }
    
    /// 显示Edge 子区域, unit: 子区域集合
    public func showEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool) {
        view.edgeAreaView.showUnit(units: units, visible: true)
    }
    
    /// 隐藏Edge 子区域, unit: 子区域集合
    public func hideEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool) {
        view.edgeAreaView.showUnit(units: units, visible: false)
    }
}

extension PlayerCotrol {
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
