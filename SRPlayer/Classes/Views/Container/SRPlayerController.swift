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
    var disposes = Set<RSObserver>()
    
    public override init(frame: CGRect) {
        self.view = SRContainerView()
        self.barManager = SRBarManager()
        self.flowManager = SRFlowManager()
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
        
        NotificationCenter.default.jm.addObserver(target: self, name: Noti.enterBackground.name.rawValue) { [weak self] (notify) in
            SRLogger.debug("enterBackground")
            guard let model = self?.flowManager.model(SRPlayFlow.self) else { return }
            if model.isPlaying {
                self?.jmSendMsg(msgName: kMsgNamePauseOrRePlay, info: nil)
            }
        }
        
        NotificationCenter.default.jm.addObserver(target: self, name: Noti.becomeActive.name.rawValue) { [weak self] (notify) in
            SRLogger.debug("becomeActive")
            self?.jmSendMsg(msgName: kMsgNamePauseOrRePlay, info: nil)
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

extension SRPlayerController: PlayerCotrol { }

extension SRPlayerController: SRPlayerGesture {
    private func brightness(_ offset: CGFloat) {
        UIScreen.main.brightness -= offset
        view.floatView.update(UIScreen.main.brightness)
    }
    
    private func volume(_ offset: CGFloat) {
        guard let model = self.flowManager.model(SRPlayFlow.self) else { return }
        if abs(model.systemVolume) >= 0.1 {
            model.systemVolume -= offset
            
//            let mpVolume = MPVolumeView()
//            mpVolume.vo
//
//            let playerController = MPMusicPlayerController.applicationMusicPlayer
//            let volume = AVAudioSession.sharedInstance().outputVolume + Float(model.systemVolume)
//            let volumeTranslateValue = floorf(volume / 0.0625) * 0.0625
//            playerController.volume =  volumeTranslateValue
            
//            view.floatView.update(model.systemVolume)
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
        SRLogger.debug("seekEnd")
    }
    
    private func floatViewAction(state: GestureState, type: ToastType) {
        switch state {
        case .begin:
            switch type {
            case .seek:
                guard let model = self.flowManager.model(SRPlayFlow.self) else { return }
                model.panSeekTargetTime = model.currentTime
            default:
                SRLogger.debug("begin")
            }
            view.floatView.show(type)
        case .change(let value):
            switch type {
            case .seek:
                seekChange(value)
            case .volume:
                volume(value)
            case .brightness:
                brightness(value)
            default:
                SRLogger.debug("change -- \(state)--\(type)")
            }
            
        case .end, .cancle:
            switch type {
            case .seek:
                seekEnd()
            default:
                SRLogger.debug("end")
            }
            view.floatView.hide()
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
