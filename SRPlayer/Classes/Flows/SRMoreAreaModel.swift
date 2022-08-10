//
//  SRMoreAreaModel.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/10.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class SRMoreAreaModel: NSObject {
    var result: Results?
    var items: [Results]?
    var type: MoreEdgeType = .none
}

extension SRMoreAreaModel: SRModel { }
