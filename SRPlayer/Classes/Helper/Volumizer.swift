//
//  Volume.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/12.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit
import MediaPlayer

fileprivate let AVAudioSessionOutputVolumeKey = "outputVolume"
class Volumizer: NSObject {
    @objc dynamic public var currVolume: Float
    public var tempSysVolume: CGFloat = 0
    public var volumeDismiss: CFAbsoluteTime
    private let session = AVAudioSession.sharedInstance()
    private let volumeView: MPVolumeView
    
    override init() {
        self.currVolume = session.outputVolume
        self.volumeView = MPVolumeView(frame: CGRect(x: -1000, y: -1000, width: 100, height: 100))
        self.volumeDismiss = CFAbsoluteTimeGetCurrent()
        super.init()
        setupSession()
    }
    
    public func hideSystem(view: UIView) {
        view.addSubview(volumeView)
    }
    
    public func showSystem() {
        volumeView.removeFromSuperview()
    }
    
    public func setSysVolum() {
        let volume = AVAudioSession.sharedInstance().outputVolume + Float(self.tempSysVolume)
        let volumeTranslateValue = floorf(volume / 0.0625) * 0.0625
        setSystemVolum(volumeTranslateValue)
    }
    
    public func setSystemVolum(_ value: Float) {
        let slider = volumeView.subviews.compactMap({ $0 as? UISlider }).first
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { // 延迟0.01秒就能够正常播放
            slider?.value = max(0, min(1, value))
        }
    }
    
    private func setupSession() {
        do {
            try session.setCategory( .playback, mode: .default, options: .mixWithOthers)
            try session.setActive(true)
        }
        catch { JMLogger.error(error.localizedDescription) }
        
        volumeView.setVolumeThumbImage(UIImage(), for: UIControl.State())
        volumeView.isUserInteractionEnabled = false
        volumeView.showsRouteButton = false
        
        session.addObserver(self, forKeyPath: AVAudioSessionOutputVolumeKey, options: .new, context: nil)
        NotificationCenter.default.jm.addObserver(target: self, name: Noti.interruption.strName) { [weak self] (notify) in
            guard
                let rawValue = notify.userInfo?[AVAudioSessionInterruptionTypeKey] as? UInt,
                let interruptionType = AVAudioSession.InterruptionType(rawValue: rawValue)
            else {
                return
            }
            
            switch interruptionType {
            case .began:
                print("Audio Session Interruption: began.")
                break
            case .ended:
                print("Audio Session Interruption: ended.")
                do { try self?.session.setActive(true) }
                catch { print("Unable to initialize AVAudioSession.") }
            @unknown default:
                fatalError("unknown AVAudioSessio.InterruptionType is addded.")
            }
        }
        
        NotificationCenter.default.jm.addObserver(target: self, name: Noti.routeChange.strName) { (notify) in
            guard
                let rawValue = notify.userInfo?[AVAudioSessionRouteChangeReasonKey] as? UInt,
                let reason = AVAudioSession.RouteChangeReason(rawValue: rawValue)
            else {
                return
            }
            
            switch reason {
            case .newDeviceAvailable:
                print("Audio seesion route changed: new device available.")
                break
            case .oldDeviceUnavailable:
                print("Audio seesion route changed: old device unavailable.")
                break
            default:
                print("Audio seesion route changed: \(reason.rawValue)")
                break
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let change = change, let value = change[.newKey] as? Float , keyPath == AVAudioSessionOutputVolumeKey else { return }
        JMLogger.debug(value)
        currVolume = value
    }
    
    deinit {
        session.removeObserver(self, forKeyPath: AVAudioSessionOutputVolumeKey, context: nil)
        NotificationCenter.default.jm.removeObserver(target: self, Noti.interruption.strName)
        NotificationCenter.default.jm.removeObserver(target: self, Noti.routeChange.strName)
    }
}
