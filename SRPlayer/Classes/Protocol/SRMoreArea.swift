//
//  SRMoreArea.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/6.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

/// MARK: -- 更多层协议
public protocol SRMoreArea: UIView {
    var content: MoreEdgeView { get }
    var type: MoreEdgeType { get }
    var isShow: Bool { set get }
}

extension SRMoreArea {
    /// 显示/隐藏 More容器
    public func update(_ show: Bool) {
        self.isShow = show
        let offset = show ? 0 : self.type.whidth
        UIView.animate(withDuration: 0.5) {
            self.content.snp.updateConstraints { make in
                make.right.equalTo(self.snp.right).offset(offset)
            }
            self.content.setNeedsLayout()
            self.content.layoutIfNeeded()
        } completion: { finish in
            self.content.isHidden = !show
        }
    }
    
    public func begin(_ type: MoreEdgeType) {
        if type == .series {
            self.content.snp.updateConstraints { make in
                make.width.equalTo(type.whidth)
                make.right.equalTo(self.snp.right).offset(type.whidth)
            }
        }
        content.reload(type)
    }
}
