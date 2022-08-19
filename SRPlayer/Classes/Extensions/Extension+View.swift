//
//  View+Extension.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

extension UIView {
    func subviewsRandColor() {
        for view in subviews {
            if view.isKind(of: UIView.self) {
                view.backgroundColor = UIColor.jmRandColor
            }
        }
    }
    
    func removellSubviews(_ callback: (UIView) -> Bool) {
        for view in subviews {
            if callback(view) {
                view.removeFromSuperview()
            }
        }
    }
}

extension String {
    var image: UIImage? {
        let scare = UIScreen.main.scale
        let imaName = String(format: "%@@%dx.png", self, Int(scare))
        if let imagePath = Bundle.bundle.path(forResource: imaName, ofType: nil) {
            return UIImage(contentsOfFile: imagePath)
        }
        return nil
    }
}

extension Array {
    public func allUnits(callback: (_ unit: Element) -> Void) {
        forEach { element in
            callback(element)
        }
    }
}

extension UIDevice {
    // 横竖屏
    static func setNewOrientation(_ orientation: UIDeviceOrientation) {
        let ori = "ori" + "ent" + "ation"
        UIDevice.current.setValue(UIDeviceOrientation.faceUp.rawValue, forKey: ori)
        UIDevice.current.setValue(orientation.rawValue, forKey: ori)
    }
}

extension CAShapeLayer {
    func radius(_ radius: CGFloat) {
        let bezier = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: 0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
        self.path = bezier.cgPath
    }
    
    func color(_ color: UIColor) {
        self.opacity = 1.0
        self.fillColor = color.cgColor
    }
    
    func position(from: CGPoint, to: CGPoint, dutation: Double) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = from
        animation.toValue = to
        animation.duration = dutation
        animation.repeatCount = HUGE
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        add(animation, forKey: "positionAnimation")
    }
    
    func scale(from: CGFloat, to: CGFloat, dutation: Double) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = from
        animation.toValue = to
        animation.duration = dutation
        animation.autoreverses = true
        animation.repeatCount = HUGE;
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        add(animation, forKey: "rotationAni")
    }
}

extension UIImageView {
    func setimage(url: String?, placerHolder: String? = nil, complate: @escaping () -> Void) {
        self.image = placerHolder?.image
        guard let url = url else {
            return
        }
        ImageCache.shared.loaderFor(url: url, callback: {
            self.image = $0
            complate()
        })
    }
}


