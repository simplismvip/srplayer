//
//  PlayerBulider.swift
//  SRPlayer
//
//  Created by jh on 2022/7/20.
//

import UIKit

public struct PlayerBulider {
    public var url: URL
    public var view: UIView?
    public var config: Config?
    
    public init(url: URL, view: UIView? = nil, config: Config? = nil) {
        self.url = url
        self.view = view
        self.config = config
    }
    
    public struct Config {
        var title: String?
        var size: CGSize?
    }
}
