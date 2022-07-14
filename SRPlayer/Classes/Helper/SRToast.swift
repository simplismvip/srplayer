//
//  SRToast.swift
//  SReader
//
//  Created by JunMing on 2021/6/15.
//

import ZJMKit

// Toast
public struct SRToast {
    static func toast(_ text: String, second: Int = 1) {
        JMTextToast.share.jmShowString(text: text, seconds: TimeInterval(second))
    }
}
