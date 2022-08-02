//
//  SRFloatView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRFloatView: SRPierceView, SRFloat_P {
    let loading: SRLoading
    public override init(frame: CGRect) {
        loading = SRLoading()
        super.init(frame: frame)
        loading.isHidden = true
        addSubview(loading)
        loading.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.centerY.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
        }
    }
    
    func startLoading() {
        loading.start()
        loading.isHidden = false
    }
    
    func stopLoading() {
        loading.stop()
        loading.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        stopLoading()
    }
}
