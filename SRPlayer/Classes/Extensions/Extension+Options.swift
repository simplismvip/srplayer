//
//  Options.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/20.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

extension Array where Element: SRItem {
    public func style(_ style: ItemStyle) -> Element? {
        return self.filter { $0.itemStyle == style }.first
    }
}

extension Array {
    public func allUnits(callback: (_ unit: Element) -> Void) {
        forEach { element in
            callback(element)
        }
    }
}
