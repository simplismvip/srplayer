//
//  SRMoreArea.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/6.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit
public protocol SRMoreContent: UIView {
    var loading: SRLoading { get }
    func reload(_ item: [MoreResult])
}

extension SRMoreContent {
    func hideLoading() {
        self.loading.stop()
    }
}

/// MARK: -- 更多层协议
public protocol SRMoreArea: UIView {
    
    var content: SRMoreContent? { get }
    var type: MoreEdgeType { set get }
    // 开始刷新数据
    func begin(_ type: MoreEdgeType)
}

extension SRMoreArea {
    /// 显示More容器
    public func show() {
        // 等待0.3秒布局完成后做动画
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.animate(withDuration: 0.5) {
                self.content?.snp.updateConstraints { make in
                    make.right.equalTo(self.snp.right)
                }
                self.content?.setNeedsLayout()
                self.content?.layoutIfNeeded()
            }
        }
    }
    
    // 隐藏More容器
    public func hide() {
        UIView.animate(withDuration: 0.5) {
            self.content?.snp.updateConstraints { make in
                make.right.equalTo(self.snp.right).offset(self.jmWidth)
            }
            self.content?.setNeedsLayout()
            self.content?.layoutIfNeeded()
        } completion: { finish in
            self.type = .none
            self.content?.hideLoading()
            self.removellSubviews { _ in true }
        }
    }
    
    // 刷新数据
    public func relodata(_ item: [MoreResult]) {
        self.content?.reload(item)
    }
}
