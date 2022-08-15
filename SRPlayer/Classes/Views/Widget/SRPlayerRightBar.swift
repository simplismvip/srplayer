//
//  SRPlayerRightBar.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRPlayerRightBar: SRPlayerControlBar {
    
    override func setupPadding() {
        view.snp.updateConstraints { make in
            make.right.equalTo(self).offset(-10)
        }
    }
}
