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
}

enum SourceType: Int {
    case local = 0
    case normal = 1
    case rtsp = 2
    case rtmp = 3
}

extension SourceType: Codable { }
extension VideoType: Codable { }

struct Model: Codable {
    var title: String
    var image: String
    var url: String
    var type: VideoType
    var stype: SourceType
}

struct Results: Codable {
    var count: String
    var results: [Model]
}
