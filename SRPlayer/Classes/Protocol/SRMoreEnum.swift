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
    var type: MoreEdgeType { get set }
}

public enum MoreEdgeType: Int {
    case playrate = 0
    case series = 1
    case resolve = 2
    case none = 3
    
    var name: String {
        switch self {
        case .playrate:
            return "playrate"
        case .series:
            return "series"
        case .resolve:
            return "resolve"
        case .none:
            return ""
        }
    }
}

extension MoreEdgeType: Codable { }

struct MoreItem: MoreEdgeItem {
    var title: String
    var image: String
    var type: MoreEdgeType
}

struct Results: Codable {
    var count: String
    var results: [MoreItem]
}
