//
//  SRPlayerController.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRPlayerController: UIView {
    public let view: SRContainerView
    public var edgeVisibleUnit: EdgeAreaUnit
    public var moreAreaVisible: Bool
    public var edgeVisibleAnimate: SREdgeVisible
    public var moreVisibleAnimate: SRVisible
    
    public override init(frame: CGRect) {
        self.view = SRContainerView()
        self.edgeVisibleUnit = .all
        self.moreAreaVisible = false
        self.edgeVisibleAnimate = { visible, unit in }
        self.moreVisibleAnimate = { _ in }
        super.init(frame: frame)
        addSubview(view)
        view.snp.makeConstraints { $0.edges.equalTo(self) }
        showEdgeAreaUnit(units: [.left, .right, .top, .bottom], animation: true)
    }

    internal func addFill(content: UIView, player: UIView, layout: SRLayout) {
        content.superview?.removeFromSuperview()
        removeFill(player)
        
        player.addSubview(content)
        content.snp.makeConstraints { make in
            layout(make, player)
        }
        
        player.setNeedsLayout()
        player.layoutIfNeeded()
    }
    
    internal func removeFill(_ player: UIView) {
        for subview in player.subviews {
            subview.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRPlayerController: CotrolProtocol {
    // 添加播放器视图到 view.player
    public func addPlayer(_ content: UIView) {
        addPlayer(content) { make, view in
            make.edges.equalTo(view)
        }
    }
    
    public func addPlayer(_ content: UIView, layout: SRLayout) {
        addFill(content: content, player: view.player, layout: layout)
    }
    
    public func removePlayerContent() {
        removeFill(view.player)
    }

    public func addBackground(_ content: UIView) {
        addBackground(content) { make, view in
            make.edges.equalTo(view)
        }
    }
    
    public func addBackground(_ content: UIView, layout: SRLayout) {
        addFill(content: content, player: view.bkgView, layout: layout)
    }
    
    public func removeBackground() {
        removeFill(view.bkgView)
    }

    public func addBarrage(_ content: UIView) {
        addBarrage(content) { make, view in
            make.edges.equalTo(view)
        }
    }
    
    public func addBarrage(_ content: UIView, layout: SRLayout) {
        addFill(content: content, player: view.barrageView, layout: layout)
    }
    
    public func removeBarrage() {
        removeFill(view.barrageView)
    }
    

    public func addEdgeAreaTop(_ content: UIView) {
        addFill(content: content, player: view.edgeAreaView.top) { make, view in
            make.edges.equalTo(view)
        }
    }
    
    public func addEdgeAreaTop(_ content: UIView, layout: SRLayout) {
        addFill(content: content, player: view.edgeAreaView.top, layout: layout)
    }
    
    public func removeEdgeAreaTop() {
        
    }

    public func addEdgeAreaLeft(_ content: UIView) {
        addFill(content: content, player: view.edgeAreaView.left) { make, view in
            make.edges.equalTo(view)
        }
    }
    
    public func addEdgeAreaLeftContent(_ content: UIView, layout: SRLayout) {
        addFill(content: content, player: view.edgeAreaView.left, layout: layout)
    }
    
    public func removeEdgeAreaLeft() {
        
    }
    

    public func addEdgeAreaRight(_ content: UIView) {
        addFill(content: content, player: view.edgeAreaView.right) { make, view in
            make.edges.equalTo(view)
        }
    }
    
    public func addEdgeAreaRight(_ content: UIView, layout: SRLayout) {
        addFill(content: content, player: view.edgeAreaView.right, layout: layout)
    }
    
    public func removeEdgeAreaRight() {
        
    }

    public func addEdgeAreaBottom(_ content: UIView) {
        addFill(content: content, player: view.edgeAreaView.bottom) { make, view in
            make.edges.equalTo(view)
        }
    }
    
    public func addEdgeAreaBottom(_ content: UIView, layout: SRLayout) {
        addFill(content: content, player: view.edgeAreaView.bottom, layout: layout)
    }
    
    public func removeEdgeAreaBottom() {
        
    }
    

    public func addMoreArea(_ content: UIView) {
        addFill(content: content, player: view.moreAreaView) { make, view in
            make.edges.equalTo(view)
        }
    }
    
    public func addMoreArea(_ content: UIView, layout: SRLayout) {
        addFill(content: content, player: view.moreAreaView, layout: layout)
    }
    
    public func removeMoreArea() {
        
    }

    public func addMask(_ content: UIView) {
        addMask(content) { make, view in
            make.edges.equalTo(view)
        }
    }
    
    public func addMask(_ content: UIView, layout: SRLayout) {
        addFill(content: content, player: view.maskAreaView, layout: layout)
    }
    
    public func removeMask() {
        removeFill(view.maskAreaView)
    }

    public func addFloat(_ content: UIView) {
        addFill(content: content, player: view.floatView) { make, view in
            make.edges.equalTo(view)
        }
    }
    
    public func removeFloat(_ content: UIView) {
        
    }

    public func showMoreArea(width: CGFloat, animation: Bool) {
        
    }
    
    public func showMoreArea(width: CGFloat, animation: Bool, completion: @escaping SRFinish) {
        
    }
    
    public func hideMoreArea(animation: Bool) {
        
    }
    
    public func hideMoreArea(animation: Bool, completion: @escaping SRFinish) {
        
    }
    
    public func showEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool) {
        showEdgeAreaUnit(units: units, animation: animation) {
            SRLogger.debug("showEdgeAreaUnit")
        }
    }
    
    public func showEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool, completion: @escaping SRFinish) {
        self.view.edgeAreaView.visibleUnit(units: units, visible: true, animation: animation)
    }
    
    public func hideEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool) {
        hideEdgeAreaUnit(units: units, animation: animation) {
            SRLogger.debug("showEdgeAreaUnit")
        }
    }
    
    public func hideEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool, completion: @escaping SRFinish) {
        view.edgeAreaView.visibleUnit(units: units, visible: false, animation: animation)
    }
}
