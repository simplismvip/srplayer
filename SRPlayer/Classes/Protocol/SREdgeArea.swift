//
//  SREdgeArea.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/6.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

/// MARK: -- 边缘层协议
public protocol SREdgeArea: UIView {
    associatedtype View: SRPierce & UIView
    /** top容器视图*/
    var top: View { get }
    /** left容器视图*/
    var left: View { get }
    /** right容器视图*/
    var right: View { get }
    /** bottom容器视图*/
    var bottom: View { get }
    /** 当前区域 */
    var units: [EdgeAreaUnit] { get set }
    /** 当前区域 */
    func showUnit(units: [EdgeAreaUnit], visible: Bool)
}

extension SREdgeArea {
    /// 显示/隐藏 子区域视图
    public func visibleUnit(units: [EdgeAreaUnit], visible: Bool, completion: SRFinish?) {
        UIView.animate(withDuration: 0.3) {
            units.forEach { unit in
                self.current(unit).alpha = visible ? 1 : 0
            }
        } completion: { finsh in
            completion?()
        }
    }
    
    /// 获取子区域是否显示
    public func unitVisible(_ unit: EdgeAreaUnit) -> Bool {
        return units.contains { unit == $0 }
    }
    
    public func current(_ type: EdgeAreaUnit) -> UIView {
        switch type {
        case .top:
            return top
        case .left:
            return self.left
        case .bottom:
            return bottom
        case .right:
            return self.right
        }
    }
}

