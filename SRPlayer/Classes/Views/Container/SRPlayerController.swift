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
    public let processM: SRProgressManager
    public let barManager: SRBarManager
    public var moreAreaVisible: Bool
    var disposes = Set<RSObserver>()
    
    public override init(frame: CGRect) {
        self.view = SRContainerView()
        self.barManager = SRBarManager()
        self.processM = SRProgressManager()
        self.moreAreaVisible = false
        super.init(frame: frame)
        addSubview(view)
        view.snp.makeConstraints { $0.edges.equalTo(self) }
        addNotioObserve()
        showEdgeAreaUnit(units: [.left, .right, .top, .bottom], animation: true)
        view.playerView.delegate = self
    }
    
    private func addNotioObserve() {
        NotificationCenter.default.jm.addObserver(target: self, name: Noti.willChangeStatusBar.name.rawValue) { (notify) in
            SRLogger.debug("UIApplicationWillChangeStatusBarOrientation")
        }
        
        NotificationCenter.default.jm.addObserver(target: self, name: Noti.didChangeStatusBar.name.rawValue) { [weak self] (notify) in
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
        
        NotificationCenter.default.jm.addObserver(target: self, name: Noti.enterBackground.name.rawValue) { (notify) in
            SRLogger.debug("enterBackground")
        }
        
        NotificationCenter.default.jm.addObserver(target: self, name: Noti.becomeActive.name.rawValue) { (notify) in
            SRLogger.debug("becomeActive")
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        disposes.forEach { $0.deallocObserver() }
        disposes.removeAll()
        NotificationCenter.default.jm.removeObserver(target: self, Noti.willChangeStatusBar.name.rawValue)
        NotificationCenter.default.jm.removeObserver(target: self, Noti.didChangeStatusBar.name.rawValue)
        NotificationCenter.default.jm.removeObserver(target: self, Noti.enterBackground.name.rawValue)
        NotificationCenter.default.jm.removeObserver(target: self, Noti.becomeActive.name.rawValue)
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension SRPlayerController: CotrolProtocol {
    public func showMoreArea(width: CGFloat, animation: Bool) {
        
    }
    
    public func hideMoreArea(animation: Bool) {
        
    }
    
    public func showEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool) {
        self.view.edgeAreaView.showUnit(units: units, visible: true)
    }
    
    public func hideEdgeAreaUnit(units: [EdgeAreaUnit], animation: Bool) {
        view.edgeAreaView.showUnit(units: units, visible: false)
    }
}

extension SRPlayerController: SRPlayerGesture {
    public func panLeftVertical(_ player: UIView, state: GestureState) {
        switch state {
        case .begin:
            view.floatView.show(.brightness)
        case .change(let value):
            SRLogger.debug(value)
            view.floatView.update(value)
        case .end, .cancle:
            SRLogger.debug("end")
            view.floatView.hide()
        }
    }
    
    public func panRightVertical(_ player: UIView, state: GestureState) {
        switch state {
        case .begin:
            view.floatView.show(.volume)
        case .change(let value):
            SRLogger.debug(value)
            view.floatView.update(value)
        case .end, .cancle:
            SRLogger.debug("end")
            view.floatView.hide()
        }
    }
    
    public func panHorizontal(_ player: UIView, state: GestureState) {
        switch state {
        case .begin:
            view.floatView.show(.seekBack)
        case .change(let value):
            SRLogger.debug(value)
            view.floatView.update(value)
        case .end, .cancle:
            SRLogger.debug("end")
            view.floatView.hide()
        }
    }
    
    public func singleClick() {
        if view.edgeAreaView.visible { // 展示
            if let item = self.barManager.left.buttonItem(.lockScreen) {
                if item.isLockScreen {
                    view.edgeAreaView.showUnit(units: [.left], visible: false)
                } else {
                    view.edgeAreaView.showUnit(units: [.left, .right, .top, .bottom], visible: false)
                }
            }
        } else {
            if let item = self.barManager.left.buttonItem(.lockScreen) {
                if item.isLockScreen {
                    view.edgeAreaView.showUnit(units: [.left], visible: true)
                } else {
                    view.edgeAreaView.showUnit(units: [.left, .right, .top, .bottom], visible: true)
                }
            }
        }
    }
    
    public func doubleClick() {
        
    }
    
    public func longPress(_ state: GestureState) {
        switch state {
        case .begin:
            view.floatView.show(.longPress)
        case .change(let value):
            SRLogger.debug(value)
            view.floatView.update(value)
        case .end, .cancle:
            SRLogger.debug("end")
            view.floatView.hide()
        }
    }
}
