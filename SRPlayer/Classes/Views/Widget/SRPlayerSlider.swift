//
//  SRPlayerSlider.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/17.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class SRPlayerSlider: UIControl {
    var trackLock: Bool
    var minValue: CGFloat  /* From 0 to 1 */
    var maxValue: CGFloat  /* From 0 to 1 */
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
    var value: CGFloat {
        willSet {
            updateValue(newValue)
        }
    }
    
    private let thumbImageView: UIImageView
    private let minTrackColorLayer: CALayer
    private let maxTrackColorLayer: CALayer
    private var disposes = Set<RSObserver>()
    override init(frame: CGRect) {
        minTrackColorLayer = CALayer()
        maxTrackColorLayer = CALayer()
        thumbImageView = UIImageView()
        thumbSize = CGSize(width: 20, height: 20)
        trackLock = false
        minTrackTintColor = UIColor.red
        maxTrackTintColor = UIColor.green
        value = 0
        minValue = 0
        maxValue = 1
        super.init(frame: frame)
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
//        self.value = min(1, max(value, 0))
        layoutValue()
    }
    
    func layoutValue() {
        let width = self.bounds.size.width - self.thumbSize.width
        let height = self.bounds.size.height
        let colorLayerY = (height - 2) / 2.0
        let padding = self.thumbSize.width / 2.0
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.maxTrackColorLayer.frame = CGRect.Rect(padding + self.value * width, colorLayerY, (1 - self.value) * width, 2);
        self.minTrackColorLayer.frame = CGRect.Rect(padding, colorLayerY, self.value * width, 2);
        CATransaction.commit()
        self.thumbImageView.frame =  CGRect.Rect(self.value * width, (height - self.thumbSize.height) / 2, self.thumbSize.width, self.thumbSize.height);
    }
    
    func intrinsicContentSize() -> CGSize {
        return CGSize(width: 100, height: 30)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        SRLogger.debug("beginTracking")
        var point = touch.location(in: self)
        point = self.thumbImageView.layer.convert(point, to: self.layer)
        return self.thumbImageView.layer.contains(point)
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        SRLogger.debug("continueTracking")
        let point = touch.location(in: self)
        let value = (point.x - self.thumbSize.width / 2) / (self.frame.size.width - self.thumbSize.width)
        let cValue = min(max(value, 1), 1)
        if self.value != cValue {
            updateValue(cValue)
            self.sendActions(for: .valueChanged)
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        SRLogger.debug("endTracking")
        self.sendActions(for: .valueChanged)
        trackLock = false
    }
    
    override func cancelTracking(with event: UIEvent?) {
        SRLogger.debug("cancelTracking")
        self.sendActions(for: .touchCancel)
        trackLock = false
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil && trackLock {
            self.sendActions(for: .touchCancel)
        }
    }
    
    @objc func sliderChangeValue(_ slider: SRPlayerSlider) {
        
    }
    
    @objc func sliderChangeValueEnd(_ slider: SRPlayerSlider) {
        
    }
    
    @objc func sliderChangeValueCanceled(_ slider: SRPlayerSlider) {
        
    }
    
    @objc func sliderValueBeganChange(_ slider: SRPlayerSlider) {
        
    }
    
    override func layoutSubviews() {
        layoutValue()
    }
    
    deinit {
        disposes.forEach { $0.deallocObserver() }
        disposes.removeAll()
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRPlayerSlider: SRItemButton {
    func configure<T: SRPlayerItem>(_ item: T) {
        if let item = item as? SRPlayerSliderItem {
            minTrackTintColor = UIColor.red
            maxTrackTintColor = UIColor.green
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.value = 0.5
            }
            
            item.observe(CGFloat.self, "value") { [weak self] newImage in
                self?.value = item.value
            }.add(&disposes)
            
            addTarget(self, action: #selector(sliderChangeValue(_:)), for: .valueChanged)
            addTarget(self, action: #selector(sliderChangeValueEnd(_:)), for: .touchUpInside)
            addTarget(self, action: #selector(sliderChangeValueEnd(_:)), for: .touchUpOutside)
            addTarget(self, action: #selector(sliderChangeValueCanceled(_:)), for: .touchCancel)
            addTarget(self, action: #selector(sliderValueBeganChange(_:)), for: .touchDown)
        }
    }
}
