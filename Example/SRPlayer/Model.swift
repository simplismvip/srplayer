//
//  Model.swift
//  SRPlayer_Example
//
//  Created by JunMing on 2022/7/17.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

enum VideoType: Int {
    case living = 0
    case vod = 1
    case local = 2
    case normal = 3
    case rtsp = 4
    case rtmp = 5
}

extension VideoType: Codable { }

struct Model: Codable {
    var title: String
    var image: String
    var url: String
    var type: VideoType
}

struct Results: Codable {
    var count: String
    var results: [Model]
}
