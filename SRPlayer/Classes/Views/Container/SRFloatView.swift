//
//  SRFloatView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

public class SRFloatView: SRPierceView, SRFloat_P {
    public var toasts: [FloatToast] = []
    private var tTypes: [ToastType] {
        return toasts.map({ $0.currType })
    }
    
    public func show(_ type: ToastType) {
        if !tTypes.contain(type), let toast = setupViews(type) {
            toasts.append(toast)
            toast.begin(type)
        }
    }
    
    public func update(_ type: ToastType) {
        current(type)?.update(type)
    }
    
    public func hide(_ type: ToastType) {
        if let toast = current(type) {
            toast.hide()
            if let index = tTypes.index(type) {
                toasts.remove(at: index)
            }
        }
    }
    
    public func remakeSubFloat(_ type: ToastType, screenType: ScreenType) {
        if let toastView = current(type) {
            switch type {
            case .seekAction:
                toastView.snp.remakeConstraints { make in
                    if #available(iOS 11, *), screenType == .full {
                        make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(10)
                        make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-40)
                    } else {
                        make.bottom.equalTo(snp.bottom).offset(-30)
                        make.left.equalTo(snp.left).offset(10)
                    }
                    make.height.equalTo(30)
                }
            default:
                JMLogger.debug("floatView remakeConstraint")
            }
        }
    }
}

extension SRFloatView {
    private func setupViews(_ type: ToastType) -> FloatToast? {
        switch type {
        case .loading:
            let loading = SRLoading()
            addSubview(loading)
            loading.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.height.equalTo(26)
                make.centerY.equalTo(snp.centerY)
                make.centerX.equalTo(snp.centerX)
            }
            return loading
        case .netSpeed:
            let loading = SRLoading()
            addSubview(loading)
            loading.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.height.equalTo(44)
                make.centerY.equalTo(snp.centerY)
                make.centerX.equalTo(snp.centerX)
            }
            return loading
        case .longPress:
            let toastView = ToastView(frame: .zero, right: UILabel())
            toastView.configText()
            addSubview(toastView)
            toastView.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.height.equalTo(30)
                make.top.equalTo(snp.top).offset(50)
                make.centerX.equalTo(snp.centerX)
            }
            return toastView
        case .volume, .brightness:
            let toastView = ToastView(frame: .zero, right: SRPlayerSlider())
            toastView.configSlider()
            addSubview(toastView)
            toastView.snp.makeConstraints { make in
                make.width.equalTo(120)
                make.height.equalTo(30)
                make.centerY.equalTo(snp.centerY)
                make.centerX.equalTo(snp.centerX)
            }
            return toastView
        case .seek:
            let toastView = QuickSeek(frame: .zero)
            addSubview(toastView)
            toastView.snp.makeConstraints { make in
                make.width.equalTo(120)
                make.height.equalTo(80)
                make.centerY.equalTo(snp.centerY)
                make.centerX.equalTo(snp.centerX)
            }
            return toastView
        case .screenShot(let point, _):
            let screenShot = SRScreenShot(frame: .zero)
            screenShot.begin(type)
            
            let offsetX = jmWidth - point.x
            let offsetY = point.y - 40
            addSubview(screenShot)
            screenShot.snp.makeConstraints { make in
                make.width.equalTo(90)
                make.height.equalTo(100)
                make.right.equalTo(snp.right).offset(-offsetX)
                make.top.equalTo(snp.top).offset(offsetY)
            }
            return screenShot
        case .seekAction:
            let toastView = QuickAction(frame: .zero)
            addSubview(toastView)
            toastView.snp.makeConstraints { make in
                make.height.equalTo(30)
                make.bottom.equalTo(snp.bottom).offset(-30)
                make.left.equalTo(snp.left).offset(10)
            }
            return toastView
        }
    }
}
