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
        view.snp.updateConstraints { make in
            make.left.equalTo(self).offset(10)
        }
    }
}
