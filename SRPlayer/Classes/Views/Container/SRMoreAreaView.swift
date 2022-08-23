//
//  SRMoreAreaView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

public class SRMoreAreaView: SRPierceView {
    public var content: SRMoreContent?
    public var type: MoreEdgeType = .none
    public var isShow: Bool {
        return !(type == .none)
    }
    
    public func begin(_ type: MoreEdgeType) {
        if self.type == type || type == .none { return }
        self.type = type
        setupViews(type)
    }
}

extension SRMoreAreaView: SRMoreArea {
    private func setupViews(_ type: MoreEdgeType) {
        switch type {
        case .playrate, .resolve, .series:
            let edgeView = MoreEdgeView(frame: .zero)
            addSubview(edgeView)
            self.content = edgeView
            edgeView.snp.makeConstraints { make in
                make.height.top.equalTo(self)
                make.width.equalTo(200)
                make.right.equalTo(snp.right).offset(200)
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
            JMLogger.debug(".none")
        }
        self.content?.backgroundColor = UIColor.black.jmComponent(0.5)
    }
}

