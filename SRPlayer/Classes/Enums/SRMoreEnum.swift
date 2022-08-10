//
//  SRMoreEnum.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/5.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

/** MoreEdge View */
protocol MoreEdgeItem: Codable {
    var title: String { get set }
    var image: String { get set }
    var event: String { get set }
}

public enum MoreEdgeType {
    case playrate(Results?)
    case series(Results?)
    case resolve(Results?)
    case more(Results?)
    case share(Results?)
    case none
    
    var name: String {
        switch self {
        case .playrate:
            return "playrate"
        case .series:
            return "series"
        case .resolve:
            return "resolve"
        case .more:
            return "resolve"
        case .share:
            return "resolve"
        case .none:
            return ""
        }
    }
}

public struct MoreItem: MoreEdgeItem {
    var title: String
    var image: String
    var event: String
}

public struct Results: Codable {
    var count: String
    var results: [MoreItem]
}
