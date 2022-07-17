//
//  SRPlayerButton.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//

import UIKit

class SRPlayerButton: UIButton {

}

extension SRPlayerButton: SRItemButton {
    func configure<T: SRPlayerItem>(_ item: T) {
        if let btnItem = item as? SRPlayerButtonItem {
            if let image = btnItem.image?.image {
                setImage(image, for: .normal)
            }
            
            if let title = btnItem.title {
                setTitle(title, for: .normal)
            }
            
            if let color = btnItem.titleColor {
                setTitleColor(color, for: .normal)
            }
        }
    }
}
