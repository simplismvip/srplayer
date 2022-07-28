//
//  SRPlayerSlider.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/17.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class SRPlayerSlider: UIView {
    let slider: UISlider
    override init(frame: CGRect) {
        slider = UISlider(frame: .zero)
        super.init(frame: frame)
        addSubview(self.slider)

        slider.snp.makeConstraints {
            $0.centerY.equalTo(snp.centerY)
            $0.height.equalTo(30)
            $0.left.equalTo(snp.left).offset(5)
            $0.right.equalTo(snp.right).offset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRPlayerSlider: SRItemButton {
    func configure<T: SRPlayerItem>(_ item: T) {
        if let item = item as? SRPlayerSliderItem {
            slider.setThumbImage(item.thumbImage, for: .normal)
        }
    }
}
