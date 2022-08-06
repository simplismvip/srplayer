//
//  SRMoreEnum.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/5.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

/** Float View */
protocol ToastRight: UIView {
    func update(_ progress: CGFloat)
}

protocol Toast: UIView {
    func begin(_ type: ToastType)
    func update(_ progress: CGFloat)
}

extension Toast {
    func hide() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        } completion: { _ in
            self.isHidden = true
        }
    }
}

/** MoreEdge View */
protocol MoreEdgeItem: Codable {
    var title: String { get set }
    var image: String { get set }
    var event: String { get set }
    var type: MoreEdgeType { get set }
}

public enum MoreEdgeType: Int {
    case playrate = 0
    case series = 1
    case resolve = 2
    case more = 3
    case share = 4
    case none = 5
    
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
    
    var whidth: CGFloat {
        switch self {
        case .playrate, .resolve, .share:
            return 160
        case .series, .more:
            return 200
        case .none:
            return 0
        }
    }
}

extension MoreEdgeType: Codable { }

struct MoreItem: MoreEdgeItem {
    var title: String
    var image: String
    var event: String
    var type: MoreEdgeType
}

struct Results: Codable {
    var count: String
    var results: [MoreItem]
}
