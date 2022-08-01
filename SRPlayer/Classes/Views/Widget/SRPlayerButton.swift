//
//  SRPlayerButton.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class SRPlayerButton: UIButton {
    var disposes = Set<RSObserver>()
    var item: SRPlayerButtonItem?
//    override func invalidateIntrinsicContentSize() {
//        let size = super.invalidateIntrinsicContentSize()
//    }
    
    deinit {
        disposes.forEach { $0.deallocObserver() }
        disposes.removeAll()
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension SRPlayerButton: SRItemButton {
    func configure<T: SRPlayerItem>(_ item: T) {
        let btnItem = SRPlayerButtonItem.convert(item)
        self.item = btnItem
        self.titleLabel?.font = btnItem.font
        self.tintColor = btnItem.tintColor
        self.setTitleColor(btnItem.titleColor, for: .normal)
        self.isUserInteractionEnabled = btnItem.isUserInteractionEnabled
        btnItem.observe(String.self, "image") { [weak self] newImage in
            self?.setImage(newImage?.image, for: .normal)
        }.add(&disposes)
        
        btnItem.observe(String.self, "title") { [weak self] title in
            self?.setTitle(title, for: .normal)
        }.add(&disposes)
        
        btnItem.observe(CGSize.self, "size") { [weak self] newSize in
            if let size = newSize, let cSize = self?.frame.size, !size.equalTo(cSize) {
                self?.invalidateIntrinsicContentSize()
            }
        }.add(&disposes)
    }
}
