//
//  SRPlayerTopBar.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRPlayerTopBar: SRPlayerControlBar {
    let battery: SRBatteryView
    override init(frame: CGRect) {
        self.battery = SRBatteryView()
        super.init(frame: frame)
        battery.isHidden = true
        addSubview(battery)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupPadding() {
        battery.isHidden = !(screenType == .full)
        if screenType == .full {
            battery.snp.remakeConstraints { make in
                make.top.equalTo(self).offset(8)
                make.left.equalTo(self).offset(20)
                make.right.equalTo(self.snp.right).offset(-20)
                make.height.equalTo(10)
            }
            
            view.snp.remakeConstraints { make in
                make.top.equalTo(self).offset(18)
                make.left.width.bottom.equalTo(self)
            }
        } else {
            battery.snp.remakeConstraints { make in
                make.top.equalTo(self).offset(8)
                make.left.equalTo(self).offset(20)
                make.right.equalTo(self.snp.right).offset(-20)
                make.height.equalTo(0)
            }
            
            view.snp.remakeConstraints { make in
                make.top.equalTo(self).offset(8)
                make.left.width.bottom.equalTo(self)
            }
        }
    }
}
