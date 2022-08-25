//
//  SRPlayerTitle.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/17.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

class SRPlayerText: UILabel {
    private var disposes = Set<RSObserver>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfLines = 0
        textColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        disposes.forEach { $0.deallocObserver() }
        disposes.removeAll()
        JMLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension SRPlayerText: SRItemButton {
    func configure(_ item: SRPlayerTextItem) {
        text = item.title
        font = item.font
        item.observe(String.self, "title") { [weak self] title in
            self?.text = title
        }.add(&disposes)
    }
}
