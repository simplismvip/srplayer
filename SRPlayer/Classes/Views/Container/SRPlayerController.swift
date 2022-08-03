//
//  SRPlayerController.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRPlayerController: UIView {
    let processM: SRProgressManager
    let barManager: SRBarManager
    var disposes = Set<RSObserver>()
    public let view: SRContainerView
    public var moreAreaVisible: Bool
    public var edgeVisibleUnit: [EdgeAreaUnit]
    public var edgeVisibleAnimate: SREdgeVisible
    public var moreVisibleAnimate: SRVisible
    
    public override init(frame: CGRect) {
        self.view = SRContainerView()
        self.barManager = SRBarManager()
        self.processM = SRProgressManager()
        self.edgeVisibleUnit = [.left, .right, .top, .bottom]
        self.moreAreaVisible = false
        self.edgeVisibleAnimate = { visible, unit in }
        self.moreVisibleAnimate = { _ in }
        super.init(frame: frame)
        addNotioObserve()
        view.playerView.delegate = self
        addSubview(view)
        view.snp.makeConstraints { $0.edges.equalTo(self) }
        showEdgeAreaUnit(units: self.edgeVisibleUnit, animation: true)
    }
    
    private func addNotioObserve() {
        NotificationCenter.default.jm.addObserver(target: self, name: NSNotification.Name.UIApplicationWillChangeStatusBarOrientation.rawValue) { (notify) in
            SRLogger.debug("UIApplicationWillChangeStatusBarOrientation")
        }
        
        NotificationCenter.default.jm.addObserver(target: self, name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation.rawValue) { [weak self] (notify) in
            let orientation = UIApplication.shared.statusBarOrientation
            switch (orientation) {
            case .portrait:
                SRLogger.debug("half")
                self?.remakePlayer(.half)
                self?.barManager.setScreenType(.half)
            case .landscapeLeft, .landscapeRight:
                SRLogger.debug("full")
                self?.remakePlayer(.full)
                self?.barManager.setScreenType(.full)
            default:
                SRLogger.debug("statusBarOrientation")
            }
        }
    }
    
    private func remakePlayer(_ type: ScreenType) {
        guard let sView = superview else { return }
        if type == .full {
            self.snp.remakeConstraints { make in
                make.edges.equalTo(sView)
            }
        } else if type == .half {
            self.snp.remakeConstraints { make in
                make.left.width.equalTo(sView)
                make.height.equalTo(min(sView.jmWidth, sView.jmHeight) * 0.56)
                if #available(iOS 11.0, *) {
                    make.top.equalTo(sView.safeAreaLayoutGuide.snp.top)
                } else {
                    make.top.equalTo(sView.snp.top)
                }
            }
        }
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
    
    deinit {
        disposes.forEach { $0.deallocObserver() }
        disposes.removeAll()
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
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
        addFill(content: content, player: view.playerView, layout: layout)
    }
    
    public func removePlayerContent() {
        removeFill(view.playerView)
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

extension SRPlayerController: SRPlayerGesture {
    public func panBeginLeftVertical(_ player: UIView) {
        
    }
    
    public func panMoveLeftVertical(player: UIView, offsetValue: CGFloat) {
        
    }
    
    public func panEndedLeftVertical(_ player: UIView) {
        
    }
    
    public func panCancelledLeftVertical(_ player: UIView) {
        
    }
    
    public func panBeginRightVertical(_ player: UIView) {
        
    }
    
    public func panMoveRightVertical(player: UIView, offsetValue: CGFloat) {
        
    }
    
    public func panEndedRightVertical(_ player: UIView) {
        
    }
    
    public func panCancelledRightVertical(_ player: UIView) {
        
    }
    
    public func panBeginHorizontal(_ player: UIView) {
        
    }
    
    public func panMoveHorizontal(player: UIView, offsetValue: CGFloat) {
        
    }
    
    public func panEndedHorizontal(_ player: UIView) {
        
    }
    
    public func panCancelledHorizontal(_ player: UIView) {
        
    }
    
    public func click(_ player: UIView) {
        if edgeVisibleUnit.isEmpty { // 展示
            if let item = self.barManager.left.buttonItem(.lockScreen) {
                if item.isLockScreen {
                    view.edgeAreaView.visibleUnit(units: [.left], visible: true, animation: true)
                    edgeVisibleUnit.append(.left)
                } else {
                    view.edgeAreaView.visibleUnit(units: [.left, .right, .top, .bottom], visible: true, animation: true)
                    edgeVisibleUnit.append(contentsOf: [.left, .right, .top, .bottom])
                }
            }
        } else {
            if let item = self.barManager.left.buttonItem(.lockScreen) {
                if item.isLockScreen {
                    view.edgeAreaView.visibleUnit(units: [.left], visible: false, animation: true)
                    edgeVisibleUnit.removeAll()
                } else {
                    view.edgeAreaView.visibleUnit(units: [.left, .right, .top, .bottom], visible: false, animation: true)
                    edgeVisibleUnit.removeAll()
                }
            }
        }
    }
    
    public func doubleClick(_ player: UIView) {
        
    }
    
    public func longPress(player: UIView) {
        
    }
}
