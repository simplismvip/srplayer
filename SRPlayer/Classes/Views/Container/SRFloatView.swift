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
        self.type = type
        setupViews(type)
        toastView?.begin(type)
    }
    
    public func update(_ progress: CGFloat) {
        toastView?.update(progress)
    }
    
    public func hide() {
        toastView?.hide()
        removellSubviews { _ in true }
    }
    
    private func setupViews(_ type: ToastType) {
        if type == .longPress {
            let toastView = ToastView(frame: .zero, right: UILabel())
            self.toastView = toastView
            toastView.configText()
            addSubview(toastView)
            toastView.snp.makeConstraints { make in
                make.width.equalTo(80)
                make.height.equalTo(40)
                make.top.equalTo(snp.top).offset(50)
                make.centerX.equalTo(snp.centerX)
            }
        } else if type == .loading {
            let loading = SRLoading()
            self.toastView = loading
            addSubview(loading)
            loading.snp.makeConstraints { make in
                make.width.equalTo(80)
                make.height.equalTo(30)
                make.centerY.equalTo(snp.centerY)
                make.centerX.equalTo(snp.centerX)
            }
        } else {
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
        }
    }
}
