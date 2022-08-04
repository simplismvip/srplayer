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
        UIDevice.current.setValue(UIDeviceOrientation.faceUp.rawValue, forKey: "orientation")
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
        
//        let orientation = UIDevice.current.orientation
//        if orientation.isLandscape {
//            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//        } else {
//            let orientationRawValue = UIInterfaceOrientation.landscapeRight.rawValue
//            UIDevice.current.setValue(orientationRawValue, forKey: "orientation")
//        }

//        self.setNeedsStatusBarAppearanceUpdate()
//        UIViewController.attemptRotationToDeviceOrientation()
    }
    
//    var interfaceOrientations: UIInterfaceOrientationMask = [.landscapeLeft, .landscapeRight] {
//        didSet {
//            print(UIDevice.current.orientation.isLandscape)
//            //强制设置成竖屏
//            if interfaceOrientations == .portrait{
//                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//            }
//            // 强制设置成横屏
//            else if !interfaceOrientations.contains(.portrait) {
//                UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//            }
//        }
//    }
}


