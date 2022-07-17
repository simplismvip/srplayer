//
//  View+Extension.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
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
        return UIImage(named: self, in: Bundle.resouseBundle , compatibleWith: nil)
    }
}

extension Array {
    public func allUnits(callback: (_ unit: Element) -> Void) {
        forEach { element in
            callback(element)
        }
    }
}
