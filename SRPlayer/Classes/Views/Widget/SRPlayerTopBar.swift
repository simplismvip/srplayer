//
//  SRPlayerTopBar.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRPlayerTopBar: SRPlayerControlBar {

    override func setupContentPadding() {
        
    }

    override func setupShadowLayerIfNeed() {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.colors = [UIColor.black.jmComponent(0.75), UIColor.jmHexColor("0x272727").jmComponent(0.0)].map({ $0.cgColor })
    }
}
//- (void)setupShadowLayerIfNeed {
//    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
//    if (self.shadow) {
//        gradientLayer.startPoint = CGPointMake(0.5f, 0.f);
//        gradientLayer.endPoint = CGPointMake(0.5f, 1.f);
//        gradientLayer.colors = @[
//                                 (__bridge id)[UIColor colorWithRGB:0x0 alpha:0.75f].CGColor,
//                                 (__bridge id)[UIColor colorWithRGB:0x272727 alpha:0.f].CGColor];
//    }else {
//        gradientLayer.colors = nil;
//    }
//
//}
