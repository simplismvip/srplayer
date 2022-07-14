//
//  SRPierceView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//

import UIKit

public class SRPierceView: UIView, SRPierce {
    public var canPierce: Bool = true
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !canPierce {
            return super.hitTest(point, with: event)
        }
        
        if isHidden || alpha <= 0.01 || isUserInteractionEnabled {
            return nil
        }
        
        let view = super.hitTest(point, with: event)
        if ((view?.isEqual(self)) != nil) {
            return nil
        } else {
            return view
        }
    }
}



