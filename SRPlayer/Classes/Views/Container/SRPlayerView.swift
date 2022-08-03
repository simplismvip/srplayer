//
//  SRPierceView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRPlayerView: SRPierceView {
    public var delegate: SRPlayerGesture?
    public var activityEvents: [PlayerEventUnit]
    var currentEvent: PlayerEventUnit
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
            let x = fabs(velocty.x)
            let y = fabs(velocty.y)
            if x > y {
                SRLogger.debug("began:水平移动")
                panDirection = .horizontal
                currentEvent = .horiPan
                delegate?.panBeginHorizontal(self)
            } else if x < y {
                if (location.x > bounds.size.width / 2) && activityEvents.contains(.pan) {
                    SRLogger.debug("右侧垂直滑动")
                    currentEvent = .vertRightPan
                    delegate?.panBeginLeftVertical(self)
                } else if (location.x <= bounds.size.width / 2) && activityEvents.contains(.pan) {
                    SRLogger.debug("左侧垂直滑动")
                    currentEvent = .vertLeftPan
                    delegate?.panBeginLeftVertical(self)
                } else {
                    SRLogger.debug("无滑动")
                }
            }
        case .changed:
            // 垂直滑动 水平滑动
            let value = (panDirection == .vertical) ? velocty.y : velocty.x
            SRLogger.debug("changed:\(value)")
            if currentEvent == .horiPan {
                SRLogger.debug("began:水平移动")
                delegate?.panMoveHorizontal(player: self, offsetValue: value)
            } else if currentEvent == .vertLeftPan {
                SRLogger.debug("左侧垂直滑动")
                delegate?.panMoveLeftVertical(player: self, offsetValue: value)
            } else if currentEvent == .vertRightPan {
                SRLogger.debug("右侧垂直滑动")
                delegate?.panMoveRightVertical(player: self, offsetValue: value)
            } else {
                SRLogger.debug("无滑动")
            }
        case .ended:
            SRLogger.debug("ended")
            if currentEvent == .horiPan {
                SRLogger.debug("began:水平移动")
                delegate?.panEndedHorizontal(self)
            } else if currentEvent == .vertLeftPan {
                SRLogger.debug("左侧垂直滑动")
                delegate?.panEndedLeftVertical(self)
            } else if currentEvent == .vertRightPan {
                SRLogger.debug("右侧垂直滑动")
                delegate?.panEndedRightVertical(self)
            } else {
                SRLogger.debug("无滑动")
            }
        case .cancelled, .failed:
            SRLogger.debug("failed")
            if currentEvent == .horiPan {
                SRLogger.debug("began:水平移动")
                delegate?.panCancelledHorizontal(self)
            } else if currentEvent == .vertLeftPan {
                SRLogger.debug("左侧垂直滑动")
                delegate?.panCancelledLeftVertical(self)
            } else if currentEvent == .vertRightPan {
                SRLogger.debug("右侧垂直滑动")
                delegate?.panCancelledRightVertical(self)
            } else {
                SRLogger.debug("无滑动")
            }
        case .possible:
            SRLogger.debug("无滑动")
        }
    }
    
    @objc func clickGestureAction(_ gesture: UITapGestureRecognizer) {
//        if currentEvent != .singleClick { return }
        delegate?.click(self)
    }
    
    @objc func doubleClickGestureAction(_ gesture: UITapGestureRecognizer) {
//        if currentEvent != .doubleClick { return }
        delegate?.doubleClick(self)
    }
    
    @objc func longPressAction(_ gesture: UILongPressGestureRecognizer) {
//        if currentEvent != .longPress { return }
        delegate?.longPress(player: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRPlayerView: UIGestureRecognizerDelegate {
    private func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        SRLogger.debug("---gestureRecognizer")
        if let isKind = otherGestureRecognizer.view?.isKind(of: UITableView.self), isKind && (gestureRecognizer == panGesture) {
            return true
        }
        return false
    }
    
    private func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
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
    public func activeEvents(_ events: [PlayerEventUnit]) {
        events.forEach { unit in
            if unit == .pan {
                panGesture.isEnabled = true
            }
            
            if unit == .singleClick {
                clickGesture.isEnabled = true
            }
            
            if unit == .doubleClick {
                doubleClickGesture.isEnabled = true
            }
            
            if unit == .longPress {
                longPressGesture.isEnabled = true
            }
        }
    }
    
    public func deactiveEvents(_ events: [PlayerEventUnit]) {
        events.forEach { unit in
            if unit == .pan {
                panGesture.isEnabled = false
            }
            
            if unit == .singleClick {
                clickGesture.isEnabled = false
            }
            
            if unit == .doubleClick {
                doubleClickGesture.isEnabled = false
            }
            
            if unit == .longPress {
                longPressGesture.isEnabled = false
            }
        }
    }
    
    public func eventsActivity(_ event: PlayerEventUnit) -> Bool {
        return activityEvents.contains(event)
    }
}
