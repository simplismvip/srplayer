//
//  SRFloatView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRFloatView: SRPierceView, SRFloat_P {
    public var loading: SRLoading
    var seekView: SRSeekView
    var type: FloatType
    
    public override init(frame: CGRect) {
        loading = SRLoading()
        seekView = SRSeekView()
        type = .loading
        super.init(frame: frame)
        hide()
        seekView.backgroundColor = UIColor.black.jmComponent(0.3)
        
        addSubview(loading)
        loading.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.centerY.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
        }
        
        addSubview(seekView)
        seekView.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.centerY.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
        }
    }
    
    func show(_ type: FloatType) {
        if self.type == type { return }
        self.type = type
        if type == .loading {
            if !loading.isHidden {
                loading.start()
                loading.isHidden = false
            }
        } else {
            if !seekView.isHidden {
                seekView.floatType(type)
                seekView.isHidden = false
            }
        }
    }
    
    func update(_ progress: CGFloat) {
        if type != .loading {
            seekView.update(progress)
        }
    }
    
    func hide() {
//        loading.isHidden = true
//        seekView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        stopLoading()
    }
}
