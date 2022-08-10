//
//  SRMoreAreaView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRMoreAreaView: SRPierceView {
    public var content: SRMoreContent?
    public var type: MoreEdgeType = .none
    
    public var isShow: Bool {
        switch type {
        case .none:
            return false
        default:
            return true
        }
    }
}

extension SRMoreAreaView: SRMoreArea {
    public func begin(_ type: MoreEdgeType) {
        self.type = type
        switch type {
        case .playrate, .resolve:
            let edgeView = MoreEdgeView(frame: .zero)
            addSubview(edgeView)
            self.content = edgeView
            edgeView.snp.makeConstraints { make in
                make.height.top.equalTo(self)
                make.width.equalTo(200)
                make.right.equalTo(snp.right).offset(200)
            }
        case .series:
            let edgeView = MoreEdgeSeries(frame: .zero)
            addSubview(edgeView)
            self.content = edgeView
            edgeView.snp.makeConstraints { make in
                make.height.top.equalTo(self)
                make.width.equalTo(240)
                make.right.equalTo(snp.right).offset(240)
            }
        case .more:
            let seriesView = MoreEdgeSetting(frame: .zero)
            addSubview(seriesView)
            self.content = seriesView
            seriesView.snp.makeConstraints { make in
                make.height.top.equalTo(self)
                make.width.equalTo(260)
                make.right.equalTo(snp.right).offset(260)
            }
        case .share:
            let shareView = MoreEdgeShare(frame: .zero)
            addSubview(shareView)
            self.content = shareView
            shareView.snp.makeConstraints { make in
                make.height.top.equalTo(self)
                make.width.equalTo(180)
                make.right.equalTo(snp.right).offset(180)
            }
        case .none:
            SRLogger.debug(".none")
        }
        self.content?.backgroundColor = UIColor.black.jmComponent(0.5)
    }
}

