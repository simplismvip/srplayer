//
//  SRPlayerController.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit
import MediaPlayer

public class SRPlayerController: UIView {
    public let view: SRContainerView
    public let flowManager: SRFlowManager
    public let barManager: SRBarManager
    internal var disposes = Set<RSObserver>()
    internal let volume: Volumizer
    public override init(frame: CGRect) {
        self.view = SRContainerView()
        self.barManager = SRBarManager()
        self.flowManager = SRFlowManager()
        self.volume = Volumizer()
        super.init(frame: frame)
        setupView()
        mainKvoBind()
        addNotioObserve()
    }
    
    private func addNotioObserve() {
        NotificationCenter.default.jm.addObserver(target: self, name: Noti.willChangeStatusBar.strName) { (notify) in
            JMLogger.debug("UIApplicationWillChangeStatusBarOrientation")
        }
        
        NotificationCenter.default.jm.addObserver(target: self, name: Noti.didChangeStatusBar.strName) { [weak self] (notify) in
            let orientation = UIApplication.shared.statusBarOrientation
            switch (orientation) {
            case .portrait:
                JMLogger.debug("half")
                self?.remakePlayer(.half)
                self?.barManager.setScreenType(.half)
            case .landscapeLeft, .landscapeRight:
                JMLogger.debug("full")
                self?.remakePlayer(.full)
                self?.barManager.setScreenType(.full)
            default:
                JMLogger.debug("statusBarOrientation")
            }
        }
        
        NotificationCenter.default.jm.addObserver(target: self, name: Noti.enterBackground.strName) { [weak self] (notify) in
            JMLogger.debug("enterBackground")
            guard let model = self?.flowManager.model(SRPlayFlow.self) else { return }
            if model.isPlaying {
                self?.jmSendMsg(msgName: kMsgNamePauseOrRePlay, info: nil)
            }
        }
        
        NotificationCenter.default.jm.addObserver(target: self, name: Noti.becomeActive.strName) { [weak self] (notify) in
            JMLogger.debug("becomeActive")
            self?.jmSendMsg(msgName: kMsgNamePauseOrRePlay, info: nil)
        }
    }
    
    private func setupView() {
        addSubview(view)
        view.snp.makeConstraints { $0.edges.equalTo(self) }
        showEdgeAreaUnit(units: [.left, .right, .top, .bottom], animation: true)
        view.playerView.delegate = self
        volume.hideSystem(view: self)
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
    
    private func mainKvoBind() {
        volume.observe(Float.self, "currVolume") { [weak self] currVolume in
            if let volum = currVolume {
                self?.view.floatView.show(.volume)
                self?.view.floatView.update(CGFloat(volum))
                self?.volume.volumeDismiss = CFAbsoluteTimeGetCurrent()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if CFAbsoluteTimeGetCurrent() - (self?.volume.volumeDismiss ?? 0) > 1.0 {
                        self?.view.floatView.hide(.volume)
                    }
                }
            }
        }.add(&disposes)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        disposes.forEach { $0.deallocObserver() }
        disposes.removeAll()
        NotificationCenter.default.jm.removeObserver(target: self, Noti.willChangeStatusBar.strName)
        NotificationCenter.default.jm.removeObserver(target: self, Noti.didChangeStatusBar.strName)
        NotificationCenter.default.jm.removeObserver(target: self, Noti.enterBackground.strName)
        NotificationCenter.default.jm.removeObserver(target: self, Noti.becomeActive.strName)
        JMLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension SRPlayerController: PlayerCotrol { }

extension SRPlayerController: SRPlayerGesture {
    private func brightness(_ offset: CGFloat) {
        JMLogger.debug("changed:左侧垂直滑动--亮度\(offset)")
        UIScreen.main.brightness -= offset
        view.floatView.update(UIScreen.main.brightness)
    }
    
    private func setVolume(_ offset: CGFloat) {
        self.volume.tempSysVolume -= offset
        if abs(self.volume.tempSysVolume) >= 0.1 {
            self.volume.setSysVolum()
            self.volume.tempSysVolume = 0
            JMLogger.debug("changed:左侧垂直滑动--音量\(offset)")
        }
    }
    
    private func seekChange(_ offset: CGFloat) {
        guard let model = self.flowManager.model(SRPlayFlow.self) else { return }
        model.panSeekOffsetTime += offset
        if (model.panSeekTargetTime + model.panSeekOffsetTime > model.duration) {
            model.panSeekOffsetTime = model.duration - model.panSeekTargetTime;
        }
        
        if (model.panSeekTargetTime + model.panSeekOffsetTime < 0) {
            model.panSeekOffsetTime = 0 - model.panSeekTargetTime;
        }
    
        view.floatView.update(model.seekProgress, text: model.seekTimeString)
    }
    
    // 发送最终seek to消息，执行
    private func seekEnd() {
        guard let model = self.flowManager.model(SRPlayFlow.self) else { return }
        let offset = model.panSeekTargetTime + model.panSeekOffsetTime
        jmSendMsg(msgName: kMsgNameActionSeekTo, info: offset as MsgObjc)
        model.panSeekOffsetTime = 0.0
        model.panSeekTargetTime = 0.0
        JMLogger.debug("seekEnd")
    }
    
    private func floatViewAction(state: GestureState, type: ToastType) {
        switch state {
        case .begin:
            switch type {
            case .seek:
                guard let model = self.flowManager.model(SRPlayFlow.self) else { return }
                model.panSeekTargetTime = model.currentTime
            default:
                JMLogger.debug("begin")
            }
            view.floatView.show(type)
        case .change(let value):
            switch type {
            case .seek:
                seekChange(value)
            case .volume:
                setVolume(value)
            case .brightness:
                brightness(value)
            default:
                JMLogger.debug("change -- \(state)--\(type)")
            }
            
        case .end, .cancle:
            switch type {
            case .seek:
                seekEnd()
            default:
                JMLogger.debug("end")
            }
            view.floatView.hide(type)
        }
    }
    
    public func panLeftVertical(_ player: UIView, state: GestureState) {
        floatViewAction(state: state, type: .brightness)
    }
    
    public func panRightVertical(_ player: UIView, state: GestureState) {
        floatViewAction(state: state, type: .volume)
    }
    
    public func panHorizontal(_ player: UIView, state: GestureState) {
        floatViewAction(state: state, type: .seek)
    }
    
    public func longPress(_ state: GestureState) {
        floatViewAction(state: state, type: .longPress)
    }
    
    public func singleClick() {
        if view.moreAreaView.isShow {
            self.hideMoreArea()
        } else {
            if let item = self.barManager.left.buttonItem(.lockScreen) {
                let visible = !view.edgeAreaView.visible
                if item.isLockScreen {
                    view.edgeAreaView.showUnit(units: [.left], visible: visible)
                } else {
                    view.edgeAreaView.showUnit(units: [.left, .right, .top, .bottom], visible: visible)
                }
            }
        }
    }
    
    public func doubleClick() {
        jmSendMsg(msgName: kMsgNamePauseOrRePlay, info: nil)
    }
}
