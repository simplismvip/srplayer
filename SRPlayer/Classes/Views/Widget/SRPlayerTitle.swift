//
//  SRPlayerTitle.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/17.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class SRPlayerTitle: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfLines = 0
        textColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRPlayerTitle: SRItemButton {
    func configure<T: SRPlayerItem>(_ item: T) {
        let title = SRPlayerTitleItem.convert(item)
        text = title.title
        font = title.font
    }
}
