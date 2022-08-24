//
//  SRWarpper.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/4.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

public struct SRWarpper {
    public let loading: UIView
    public let battery: UIView
    public let slider: UIView
    
    public init() {
        self.loading = SRLoading()
        self.battery = SRBatteryView()
        self.slider = SRPlayerSlider()
    }
    
    public func start() {
        (loading as? SRLoading)?.start()
    }
    
    public func stop() {
        (loading as? SRLoading)?.stop()
    }
    
    public func setvalue(_ value: CGFloat) {
        (slider as? SRPlayerSlider)?.value = value
    }
    
    public func thumbImage(_ image: UIImage) {
        (slider as? SRPlayerSlider)?.thumbImage = image
    }
    
    public func maxColor(_ color: UIColor) {
        (slider as? SRPlayerSlider)?.maxTrackTintColor = color
    }
    
    public func minCOlor(_ color: UIColor) {
        (slider as? SRPlayerSlider)?.minTrackTintColor = color
    }
}
