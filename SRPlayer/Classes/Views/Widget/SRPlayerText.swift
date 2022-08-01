//
//  SRPlayerTitle.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/17.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

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
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension SRPlayerText: SRItemButton {
    func configure<T: SRPlayerItem>(_ item: T) {
        let title = SRPlayerTextItem.convert(item)
        text = title.text
        font = title.font
        
        title.observe(String.self, "text") { [weak self] title in
            self?.text = title
        }.add(&disposes)
    }
}
