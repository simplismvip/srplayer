//
//  SRPlayerSlider.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/17.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

class SRPlayerSlider: UIControl {
    var trackLock: Bool = false
    var thumbSize: CGSize
    
    var minTrackTintColor: UIColor {
        willSet {
            minTrackColorLayer.backgroundColor = newValue.cgColor
        }
    }
    var maxTrackTintColor: UIColor {
        willSet {
            maxTrackColorLayer.backgroundColor = newValue.cgColor
        }
    }
    
    var thumbImage: UIImage? {
        willSet {
            thumbImageView.image = newValue
        }
    }
    
    /* From 0 to 1 */
    var value: CGFloat = 0.0
    let thumbImageView: UIImageView
    
    private var loadFirst: Bool = true
    private let minTrackColorLayer: CALayer
    private let maxTrackColorLayer: CALayer
    private var disposes = Set<RSObserver>()
    
    override init(frame: CGRect) {
        minTrackColorLayer = CALayer()
        maxTrackColorLayer = CALayer()
        thumbImageView = UIImageView()
        thumbSize = CGSize(width: 8, height: 8)
        minTrackTintColor = UIColor.red
        maxTrackTintColor = UIColor.green
        super.init(frame: frame)
        thumbImageView.layer.cornerRadius = 4
        thumbImageView.backgroundColor = UIColor.cyan
        
        layer.addSublayer(minTrackColorLayer)
        layer.addSublayer(maxTrackColorLayer)
        addSubview(thumbImageView)
        
        minTrackColorLayer.contentsScale = UIScreen.main.scale
        minTrackColorLayer.masksToBounds = true
        
        maxTrackColorLayer.contentsScale = UIScreen.main.scale
        maxTrackColorLayer.masksToBounds = true

        thumbImageView.backgroundColor = UIColor.white
        thumbImageView.contentMode = .scaleAspectFit
    }

    func updateValue(_ value: CGFloat) {
        if trackLock { return }
        self.value = min(1, max(value, 0))
        layoutValue(self.value)
    }
    
    func layoutValue(_ value: CGFloat) {
        let w = bounds.size.width - thumbSize.width
        if w <= 0 { return }
        
        let h = bounds.size.height
        let colorLayerY = (h - 2) / 2.0
        let padding = thumbSize.width / 2.0
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        maxTrackColorLayer.frame = CGRect.Rect(padding + value * w, colorLayerY, (1 - value) * w, 2)
        minTrackColorLayer.frame = CGRect.Rect(padding, colorLayerY, value * w, 2)
        CATransaction.commit()
        thumbImageView.frame =  CGRect.Rect(value * w, (h - thumbSize.height) / 2, thumbSize.width, thumbSize.height)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        JMLogger.debug("beginTracking")
        var point = touch.location(in: self)
        point = thumbImageView.layer.convert(point, to: self.layer)
        if thumbImageView.layer.contains(point) {
            trackLock = true
            return true
        }
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        JMLogger.debug("continueTracking")
        let point = touch.location(in: self)
        let value = (point.x - self.thumbSize.width / 2) / (self.frame.size.width - self.thumbSize.width)
        let cValue = min(max(value, 0), 1)
        if self.value != cValue {
            updateValue(min(max(value, 0), 1))
            self.sendActions(for: .valueChanged)
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        JMLogger.debug("endTracking")
        self.sendActions(for: .valueChanged)
        trackLock = false
    }
    
    override func cancelTracking(with event: UIEvent?) {
        JMLogger.debug("cancelTracking")
        self.sendActions(for: .touchCancel)
        trackLock = false
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil && trackLock {
            self.sendActions(for: .touchCancel)
        }
    }

    override func layoutSubviews() {
        if loadFirst {
            updateValue(self.value)
            loadFirst.toggle()
        }
    }
    
    deinit {
        disposes.forEach { $0.deallocObserver() }
        disposes.removeAll()
        JMLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRPlayerSlider: SRItemButton {
    func configure(_ item: SRPlayerSliderItem) {
        minTrackTintColor = item.minTintColor
        maxTrackTintColor = item.maxTintColor
        updateValue(item.value)
        item.observe(CGFloat.self, "value") { [weak self] newImage in
            self?.updateValue(newImage ?? 0)
        }.add(&disposes)
        
        addTarget(self, action: #selector(sliderChangeValue(_:)), for: .valueChanged)
        addTarget(self, action: #selector(sliderChangeValueEnd(_:)), for: .touchUpInside)
        addTarget(self, action: #selector(sliderChangeValueEnd(_:)), for: .touchUpOutside)
        addTarget(self, action: #selector(sliderChangeValueCanceled(_:)), for: .touchCancel)
        addTarget(self, action: #selector(sliderValueBeganChange(_:)), for: .touchDown)
    }
    
    @objc func sliderChangeValue(_ slider: SRPlayerSlider) {
        
    }
    
    @objc func sliderChangeValueEnd(_ slider: SRPlayerSlider) {
        
    }
    
    @objc func sliderChangeValueCanceled(_ slider: SRPlayerSlider) {
        
    }
    
    @objc func sliderValueBeganChange(_ slider: SRPlayerSlider) {
        
    }
}

extension SRPlayerSlider: ToastRight {
    func update(_ progress: CGFloat) {
        updateValue(progress)
    }
}
