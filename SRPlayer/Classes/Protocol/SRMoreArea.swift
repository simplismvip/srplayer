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
    var type: MoreEdgeType { set get }
}

extension SRMoreArea {
    /// 显示/隐藏 More容器
    public func update(_ show: Bool, animation: Bool) {
        let offset = show ? 0 : self.content.jmWidth
        UIView.animate(withDuration: 0.5) {
            self.content.snp.updateConstraints { make in
                make.right.equalTo(self.snp.right).offset(offset)
            }
        } completion: { finish in
            self.content.isHidden = !show
        }
    }
    
    public func begin(_ type: MoreEdgeType) {
        if type == .series {
            self.content.snp.updateConstraints { make in
                make.width.equalTo(160)
                make.right.equalTo(self.snp.right).offset(160)
            }
        }
        content.reload(type)
    }
}
