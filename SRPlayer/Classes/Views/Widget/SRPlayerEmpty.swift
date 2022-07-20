//
//  SRPlayerEmpty.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/17.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class SRPlayerEmpty: UIView {

}

extension SRPlayerEmpty: SRItemButton {
    func configure<T: SRPlayerItem>(_ item: T) { }
}
