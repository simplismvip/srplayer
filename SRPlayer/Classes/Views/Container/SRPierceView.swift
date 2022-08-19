//
//  SRPierceView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRPierceView: UIView, SRPierce {
    public var canPierce: Bool = true
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !canPierce {
            return super.hitTest(point, with: event)
        }

        if isHidden || alpha <= 0.01 || !isUserInteractionEnabled {
            return nil
        }

        if let view = super.hitTest(point, with: event), !view.isEqual(self) {
            return view
        } else {
            return nil
        }
    }
    
    deinit {
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}



