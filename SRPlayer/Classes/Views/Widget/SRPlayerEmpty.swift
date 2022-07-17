//
//  SRPlayerEmpty.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/17.
//

import UIKit

class SRPlayerEmpty: UIView {

}

extension SRPlayerEmpty: SRItemButton {
    func configure<T: SRPlayerItem>(_ item: T) { }
}
