//
//  SREdgeAreaView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import SnapKit

public class SREdgeAreaView: UIView {
    public var top: SRPierceView
    public var left: SRPierceView
    public var right: SRPierceView
    public var bottom: SRPierceView
    public var visibleUnits: [EdgeAreaUnit]
    public var visibleAnimate: SREdgeVisible
    
    private var top_topToTop: ConstraintMakerEditable?
    private var top_bottomToTop: ConstraintMakerEditable?
    
    private var left_leftToLeft: ConstraintMakerEditable?
    private var left_rightToLeft: ConstraintMakerEditable?
    
    private var right_rightToRight: ConstraintMakerEditable?
    private var right_leftToRight: ConstraintMakerEditable?
    
    private var bottom_bottomToBottom: ConstraintMakerEditable?
    private var bottom_topToBottom: ConstraintMakerEditable?
    
    public override init(frame: CGRect) {
        self.top = SRPierceView()
        self.top.canPierce = true
        
        self.left = SRPierceView()
        self.left.canPierce = true
        
        self.right = SRPierceView()
        self.right.canPierce = true
        
        self.bottom = SRPierceView()
        self.bottom.canPierce = true
        
        self.visibleUnits = []
        self.visibleAnimate = { unit, a in }
        
        super.init(frame: frame)
        addSubview(left)
        addSubview(right)
        addSubview(top)
        addSubview(bottom)
        
        layoutEdgeViews()
        subviewsRandColor()
    }
    
    internal func removeOf(_ unit: EdgeAreaUnit) {
        if let index = visibleUnits.index(of: unit) {
            visibleUnits.remove(at: index)
        }
    }
    
    internal func allUnits(callback: (_ unit: EdgeAreaUnit) -> Void) {
        for unit in visibleUnits {
            callback(unit)
        }
    }
    
    internal func layoutEdgeViews() {
        top.snp.makeConstraints { make in
            top_topToTop = make.top.equalTo(self)
            top_topToTop?.constraint.deactivate()
            top_bottomToTop = make.bottom.equalTo(self)
            
            if #available(iOS 11, *) {
                make.left.equalTo(self.safeAreaLayoutGuide.snp.left)
                make.right.equalTo(self.safeAreaLayoutGuide.snp.right)
            } else {
                make.left.right.equalTo(self)
            }
            make.height.greaterThanOrEqualTo(CGFloat.leastNormalMagnitude)
        }
        
        left.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                left_leftToLeft = make.left.equalTo(safeAreaLayoutGuide.snp.left)
            } else {
                left_leftToLeft = make.left.equalTo(snp.left)
            }
            left_leftToLeft?.constraint.deactivate()
            left_rightToLeft = make.right.equalTo(snp.left)
            
            make.top.bottom.equalTo(self)
            make.width.greaterThanOrEqualTo(CGFloat.leastNormalMagnitude)
        }
        
        right.snp.makeConstraints { make in
            if #available(iOS 11, *) {
                right_rightToRight = make.right.equalTo(safeAreaLayoutGuide.snp.right)
            } else {
                right_rightToRight = make.right.equalTo(self)
            }
            
            right_rightToRight?.constraint.deactivate()
            right_leftToRight = make.left.equalTo(snp.right)
            
            make.top.bottom.equalTo(self)
            make.width.greaterThanOrEqualTo(CGFloat.leastNormalMagnitude)
        }
        
        bottom.snp.makeConstraints { make in
            bottom_bottomToBottom = make.bottom.equalTo(self)
            bottom_bottomToBottom?.constraint.deactivate()
            bottom_topToBottom = make.top.equalTo(snp.bottom)
            
            if #available(iOS 11, *) {
                make.left.equalTo(self.safeAreaLayoutGuide.snp.left)
                make.right.equalTo(self.safeAreaLayoutGuide.snp.right)
            } else {
                make.left.right.equalTo(self)
            }
            make.height.greaterThanOrEqualTo(CGFloat.leastNormalMagnitude)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SREdgeAreaView: SREdgeArea {
    public func visibleUnit(units: [EdgeAreaUnit], visible: Bool, animation: Bool) {
        visibleUnit(units: units, visible: visible, animation: animation) {
            print("visibleUnit")
        }
    }
    
    public func visibleUnit(units: [EdgeAreaUnit], visible: Bool, animation: Bool, completion: @escaping SRFinish) {
        visibleUnits.append(contentsOf: units)
        allUnits { unit in
            if unit == .top {
                top.isHidden = !visible
                if visible {
                    top_topToTop?.constraint.activate()
                    top_bottomToTop?.constraint.deactivate()
                } else {
                    top_topToTop?.constraint.deactivate()
                    top_bottomToTop?.constraint.activate()
                }
            }
            
            if unit == .left {
                self.left.isHidden = !visible
                if visible {
                    left_leftToLeft?.constraint.activate()
                    left_rightToLeft?.constraint.deactivate()
                } else {
                    left_leftToLeft?.constraint.deactivate()
                    left_rightToLeft?.constraint.activate()
                }
            }
            
            if unit == .right {
                self.right.isHidden = !visible
                if visible {
                    right_rightToRight?.constraint.activate()
                    right_leftToRight?.constraint.deactivate()
                } else {
                    right_rightToRight?.constraint.deactivate()
                    right_leftToRight?.constraint.activate()
                }
            }
            
            if unit == .bottom {
                bottom.isHidden = !visible
                if visible {
                    bottom_bottomToBottom?.constraint.activate()
                    bottom_topToBottom?.constraint.deactivate()
                } else {
                    bottom_bottomToBottom?.constraint.deactivate()
                    bottom_topToBottom?.constraint.activate()
                }
            }
        }
        
        if animation {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
                self.allUnits { unit in
                    self.visibleAnimate(visible, unit)
                }
            } completion: { finished in
                completion()
            }
        } else {
            completion()
        }
    }
    
    public func subAreaUnitCurrentDisplayed(unit: EdgeAreaUnit) -> Bool {
        return visibleUnits.contains { unit == $0 }
    }
}
