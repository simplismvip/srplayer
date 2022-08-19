//
//  RequestData.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/19.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

// 给外部类使用，请求数据，有些数据需要外部提供，遵循该协议
public protocol RequestData: NSObject {
    associatedtype RequestType
    func request(_ type: RequestType)
    func registerMsg()
}

extension RequestData {
    /// 把外部类关联到播放器
    public func associatPlayer(_ player: SRPlayerController) {
        if let router = player.msgRouter {
            self.jmSetAssociatedMsgRouter(router: router)
            self.registerMsg()
        }
    }
}

