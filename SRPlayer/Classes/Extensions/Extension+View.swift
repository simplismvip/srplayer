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


