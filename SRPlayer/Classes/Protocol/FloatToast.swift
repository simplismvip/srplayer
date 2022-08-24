//
//  Toast.swift
//  SRPlayer
//
//  Created by jh on 2022/8/10.
//

import UIKit

/** Float View */
protocol ToastRight: UIView {
    func update(_ progress: CGFloat)
}

public protocol FloatToast: UIView {
    var currType: ToastType { get set }
    func begin(_ type: ToastType)
    func update(_ type: ToastType)
}

extension FloatToast {
    func hide() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
}
