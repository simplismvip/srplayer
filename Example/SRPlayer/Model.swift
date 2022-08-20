//
//  Model.swift
//  SRPlayer_Example
//
//  Created by JunMing on 2022/7/17.
//  Copyright © 2022 JunMing. All rights reserved.
//

import Foundation

enum SourceType: Int {
    case home = 0
    case local = 2
    case vod = 3
    case rtsp = 4
    case rtmp = 5
    case living = 6
    
    var name: String {
        switch self {
        case .home:
            return "home"
        case .local:
            return "local"
        case .vod:
            return "remote"
        case .rtmp:
            return "rtmp"
        case .rtsp:
            return "rtsp"
        case .living:
            return "living"
        }
    }
}

extension SourceType: Codable { }

struct Model: Codable {
    var title: String
    var image: String
    var url: String
    var type: SourceType
}

struct Results: Codable {
    var count: String
    var results: [Model]
}
