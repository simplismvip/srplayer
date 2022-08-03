//
//  SREdgeAreaView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import SnapKit

public class SREdgeAreaView: SRPierceView {
    public var top: SRPierceView
    public var left: SRPierceView
    public var right: SRPierceView
    public var bottom: SRPierceView
    public var units: [EdgeAreaUnit]
    public var visible: Bool = false
    public override init(frame: CGRect) {
        self.top = SRPierceView()
        self.left = SRPierceView()
        self.right = SRPierceView()
        self.bottom = SRPierceView()
        self.units = []
        super.init(frame: frame)
        layoutEdgeViews()
    }
    
    private func layoutEdgeViews() {
        [left, right, top, bottom].forEach { addSubview($0) }
        top.snp.makeConstraints { make in
            if #available(iOS 11, *) {
                make.left.equalTo(self.safeAreaLayoutGuide.snp.left)
                make.right.equalTo(self.safeAreaLayoutGuide.snp.right)
                make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            } else {
                make.left.right.equalTo(self)
                make.top.equalTo(self)
            }
            make.height.greaterThanOrEqualTo(CGFloat.leastNormalMagnitude)
        }
        
        left.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.left.equalTo(self.safeAreaLayoutGuide.snp.left)
            } else {
                make.left.equalTo(self)
            }
            make.top.bottom.equalTo(self)
            make.width.greaterThanOrEqualTo(CGFloat.leastNormalMagnitude)
        }
        
        right.snp.makeConstraints { make in
            if #available(iOS 11, *) {
                make.right.equalTo(self.safeAreaLayoutGuide.snp.right)
            } else {
                make.right.equalTo(self)
            }
            make.top.bottom.equalTo(self)
            make.width.greaterThanOrEqualTo(CGFloat.leastNormalMagnitude)
        }
        
        bottom.snp.makeConstraints { make in
            if #available(iOS 11, *) {
                make.left.equalTo(self.safeAreaLayoutGuide.snp.left)
                make.right.equalTo(self.safeAreaLayoutGuide.snp.right)
                make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.left.right.equalTo(self)
                make.bottom.equalTo(self)
            }
            
            make.height.greaterThanOrEqualTo(CGFloat.leastNormalMagnitude)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SREdgeAreaView: SREdgeArea {
    public func visibleUnit(units: [EdgeAreaUnit], visible: Bool, animation: Bool, completion: SRFinish? = nil) {
        self.units = units
        self.visible = visible
        UIView.animate(withDuration: 0.3) {
            units.forEach { unit in
                if unit == .top {
                    self.top.alpha = visible ? 1 : 0
                }
                
                if unit == .left {
                    self.left.alpha = visible ? 1 : 0
                }
                
                if unit == .right {
                    self.right.alpha = visible ? 1 : 0
                }
                
                if unit == .bottom {
                    self.bottom.alpha = visible ? 1 : 0
                }
            }
        } completion: { finsh in
            completion?()
        }
    }
    
    public func unitVisible(_ unit: EdgeAreaUnit) -> Bool {
        return units.contains { unit == $0 }
    }
}
