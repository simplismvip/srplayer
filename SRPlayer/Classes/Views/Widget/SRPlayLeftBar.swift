//
//  SRPlayLeftBar.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRPlayLeftBar: SRPlayerControlBar {
    override func setupPadding() {
        
    }

    override func setupShadow() {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.colors = [UIColor.black.jmComponent(0.75), UIColor.jmHexColor("0x272727").jmComponent(0.0)].map({ $0.cgColor })
    }
}
