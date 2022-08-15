//
//  SRPlayerBottomBar.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRPlayerBottomBar: SRPlayerControlBar {
    override func setupPadding() {
        if screenType == .full {
            view.snp.remakeConstraints { make in
                make.bottom.equalTo(self).offset(-5)
                make.left.width.bottom.equalTo(self)
            }
        } else {
            view.snp.remakeConstraints { make in
                make.bottom.equalTo(self).offset(-3)
                make.left.width.bottom.equalTo(self)
            }
        }
    }
}
