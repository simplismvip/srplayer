//
//  SRFloatView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRFloatView: SRPierceView, SRFloat_P {
    private var toastView: Toast?
    private var type: ToastType = .none
    
    public func show(_ type: ToastType) {
        if self.type == type || type == .none { return }
        self.type = type
        hide()
        setupViews(type)
        toastView?.begin(type)
        SRLogger.debug("卡顿展示--\(type)")
    }
    
    public func update(_ progress: CGFloat, text: String? = nil) {
        toastView?.update(progress, text: text)
    }
    
    public func hide() {
        SRLogger.debug("卡顿展示--隐藏 \(type)")
        toastView?.hide()
        toastView = nil
        self.type = .none
        removellSubviews { _ in true }
    }
}

extension SRFloatView {
    private func setupViews(_ type: ToastType) {
        switch type {
        case .loading:
            let loading = SRLoading()
            self.toastView = loading
            addSubview(loading)
            loading.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.height.equalTo(26)
                make.centerY.equalTo(snp.centerY)
                make.centerX.equalTo(snp.centerX)
            }
        case .netSpeed:
            let loading = SRLoading()
            self.toastView = loading
            loading.backgroundColor = UIColor.red
            addSubview(loading)
            loading.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.height.equalTo(50)
                make.centerY.equalTo(snp.centerY)
                make.centerX.equalTo(snp.centerX)
            }
        case .longPress:
            let toastView = ToastView(frame: .zero, right: UILabel())
            self.toastView = toastView
            toastView.configText()
            addSubview(toastView)
            toastView.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.height.equalTo(30)
                make.top.equalTo(snp.top).offset(50)
                make.centerX.equalTo(snp.centerX)
            }
        case .volume, .brightness:
            let toastView = ToastView(frame: .zero, right: SRPlayerSlider())
            self.toastView = toastView
            toastView.configSlider()
            addSubview(toastView)
            toastView.snp.makeConstraints { make in
                make.width.equalTo(120)
                make.height.equalTo(30)
                make.centerY.equalTo(snp.centerY)
                make.centerX.equalTo(snp.centerX)
            }
        case .seek:
            let toastView = QuickSeek(frame: .zero)
            self.toastView = toastView
            addSubview(toastView)
            toastView.snp.makeConstraints { make in
                make.width.equalTo(120)
                make.height.equalTo(80)
                make.centerY.equalTo(snp.centerY)
                make.centerX.equalTo(snp.centerX)
            }
        case .screenShot(let point, _):
            let screenShot = SRScreenShot(frame: .zero)
            self.toastView = screenShot
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.hide()
            }
        case .none:
            SRLogger.debug("None")
        }
    }
}
