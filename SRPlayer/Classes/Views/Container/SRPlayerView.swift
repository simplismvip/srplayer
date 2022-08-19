//
//  SRPierceView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRPlayerView: SRPierceView {
    public weak var delegate: SRPlayerGesture?
    public var activityEvents: [GestureUnit]
    var currentEvent: GestureUnit
    var panDirection: PanDirection
    
    lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        gesture.maximumNumberOfTouches = 1
        gesture.delegate = self
        return gesture
    }()
    
    lazy var clickGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickGestureAction(_:)))
        gesture.delegate = self
        return gesture
    }()
    
    lazy var doubleClickGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(doubleClickGestureAction(_:)))
        gesture.numberOfTapsRequired = 2
        gesture.delegate = self
        return gesture
    }()
    
    lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
        gesture.minimumPressDuration = 1.0
        gesture.numberOfTouchesRequired = 1
        gesture.delegate = self
        return gesture
    }()
    
    override init(frame: CGRect) {
        activityEvents = [.pan, .singleClick, .doubleClick, .longPress]
        panDirection = .vertical
        currentEvent = .horiPan
        super.init(frame: frame)
        addGestureRecognizer(panGesture)
        addGestureRecognizer(clickGesture)
        addGestureRecognizer(doubleClickGesture)
        addGestureRecognizer(longPressGesture)
    }
    
    @objc func panGestureAction(_ gesture: UIPanGestureRecognizer) {
        // 手指在视图上移动的位置（x,y）向下和向右为正，向上和向左为负。
        // let translate = gesture.translation(in: self)
        // 手指在视图上的位置（x,y）就是手指在视图本身坐标系的位置。
        let location = gesture.location(in: self)
        
        // 手指在视图上移动的速度（x,y）, 正负也是代表方向，值得一体的是在绝对值上|x| > |y| 水平移动， |y|>|x| 竖直移动。
        let velocty = gesture.velocity(in: self)
        
        switch gesture.state {
        case .began:
            let x = abs(velocty.x)
            let y = abs(velocty.y)
            if x > y {
                SRLogger.debug("began:水平移动")
                panDirection = .horizontal
                currentEvent = .horiPan
                delegate?.panHorizontal(self, state: .begin)
            } else if x < y {
                if (location.x > bounds.size.width / 2) && activityEvents.contains(.pan) {
                    SRLogger.debug("began:右侧垂直滑动")
                    currentEvent = .vertRightPan
                    delegate?.panRightVertical(self, state: .begin)
                } else if (location.x <= bounds.size.width / 2) && activityEvents.contains(.pan) {
                    SRLogger.debug("began:左侧垂直滑动")
                    currentEvent = .vertLeftPan
                    delegate?.panLeftVertical(self, state: .begin)
                } else {
                    SRLogger.debug("无滑动")
                }
            }
        case .changed:
            // 垂直滑动 水平滑动
            let value = (panDirection == .vertical) ? velocty.y : velocty.x
            if currentEvent == .horiPan {
                SRLogger.debug("changed:水平移动--快进快退")
                delegate?.panHorizontal(self, state: .change(value/200))
            } else if currentEvent == .vertLeftPan {
                SRLogger.debug("changed:左侧垂直滑动--亮度")
                delegate?.panLeftVertical(self, state: .change(value/1000))
            } else if currentEvent == .vertRightPan {
                SRLogger.debug("changed:右侧垂直滑动---声音")
                delegate?.panRightVertical(self, state: .change(value/1000))
            } else {
                SRLogger.debug("无滑动")
            }
        case .ended:
            SRLogger.debug("ended")
            if currentEvent == .horiPan {
                SRLogger.debug("ended:水平移动")
                delegate?.panHorizontal(self, state: .end)
            } else if currentEvent == .vertLeftPan {
                SRLogger.debug("ended:左侧垂直滑动")
                delegate?.panLeftVertical(self, state: .end)
            } else if currentEvent == .vertRightPan {
                SRLogger.debug("ended:右侧垂直滑动")
                delegate?.panRightVertical(self, state: .end)
            } else {
                SRLogger.debug("无滑动")
            }
        case .cancelled, .failed:
            SRLogger.debug("failed")
            if currentEvent == .horiPan {
                SRLogger.debug("failed:水平移动")
                delegate?.panHorizontal(self, state: .cancle)
            } else if currentEvent == .vertLeftPan {
                SRLogger.debug("failed:左侧垂直滑动")
                delegate?.panLeftVertical(self, state: .cancle)
            } else if currentEvent == .vertRightPan {
                SRLogger.debug("failed:右侧垂直滑动")
                delegate?.panRightVertical(self, state: .cancle)
            } else {
                SRLogger.debug("无滑动")
            }
        case .possible:
            SRLogger.debug("无滑动")
        @unknown default:
            fatalError()
        }
    }
    
    @objc func clickGestureAction(_ gesture: UITapGestureRecognizer) {
//        if currentEvent != .singleClick { return }
        delegate?.singleClick()
    }
    
    @objc func doubleClickGestureAction(_ gesture: UITapGestureRecognizer) {
//        if currentEvent != .doubleClick { return }
        delegate?.doubleClick()
    }
    
    @objc func longPressAction(_ gesture: UILongPressGestureRecognizer) {
//        if currentEvent != .longPress { return }
        switch gesture.state {
        case .began:
            delegate?.longPress(.begin)
        case .changed:
            delegate?.longPress(.change(0))
        case .cancelled, .failed:
            delegate?.longPress(.cancle)
        case .possible:
            SRLogger.debug("无长按")
        case .ended:
            delegate?.longPress(.end)
        @unknown default:
            fatalError()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRPlayerView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        SRLogger.debug("---gestureRecognizer")
        if let isKind = otherGestureRecognizer.view?.isKind(of: UITableView.self), isKind && (gestureRecognizer == panGesture) {
            return true
        }
        return false
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        SRLogger.debug("gestureRecognizer---")
        if gestureRecognizer == panGesture {
            return false
        }
        
        if otherGestureRecognizer == clickGesture {
            return false
        }
        
        return true
    }
}

extension SRPlayerView: SRPlayer_P {
    public func enableEvents(_ events: [GestureUnit], enabled: Bool) {
        events.forEach { unit in
            if unit == .pan {
                panGesture.isEnabled = enabled
            }
            
            if unit == .singleClick {
                clickGesture.isEnabled = enabled
            }
            
            if unit == .doubleClick {
                doubleClickGesture.isEnabled = enabled
            }
            
            if unit == .longPress {
                longPressGesture.isEnabled = enabled
            }
        }
    }
}
