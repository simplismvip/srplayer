//
//  SRLoading.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRLoading: UIView {
    
    enum MoveDirection {
        case positive
        case negatiove
    }
    
    let content: UIView = {
        let view = UIView(frame: CGRect.Rect(0, 0, 25.2, 24))
        view.layer.masksToBounds = true;
        return view
    }()
    
    lazy var left: UIView = {
        let view = UIView(frame: CGRect.Rect(0, 0, 12, 12))
        view.center = CGPoint(x: 12 * 0.5, y: self.content.jmHeight * 0.5)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true;
        view.backgroundColor = UIColor.green
        return view
    }()
    
    lazy var centerV: UIView = {
        let view = UIView(frame: CGRect.Rect(0, 0, 12, 12))
        view.center = CGPoint(x: 12 * 0.5, y: self.content.jmHeight * 0.5)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true;
        view.backgroundColor = UIColor.black
        return view
    }()
    
    lazy var right: UIView = {
        let view = UIView(frame: CGRect.Rect(0, 0, 12, 12))
        view.center = CGPoint(x: self.content.jmWidth - 12 * 0.5, y: self.content.jmHeight * 0.5)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true;
        view.backgroundColor = UIColor.red
        return view
    }()
    
    var displaylink: CADisplayLink?
    var direction: MoveDirection = .positive
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(content)
        content.addSubview(left)
        content.addSubview(centerV)
        content.addSubview(right)
        content.bringSubview(toFront: left)
        updatePosition(0)
    }
    
    @objc public func start() {
        pause()
        displaylink = CADisplayLink(target: self, selector: #selector(update))
        displaylink?.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    public func pause() {
        displaylink?.invalidate()
        displaylink = nil
    }
    
    public func stop() {
        pause()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(start), object: nil)
        left.addSubview(centerV)
        content.bringSubview(toFront: right)
        direction = .positive
        updatePosition(0)
    }
    
    public func reset() {
        pause()
        self.perform(#selector(start), with: nil, afterDelay: 0.18)
    }
    
    func updatePosition(_ progress: CGFloat) {
        var center = left.center
        center.x = 12 * 0.5 + 1.1 * 12 * progress
        left.center = center
        
        center = right.center
        center.x = 12 * 1.6 - 1.1 * 12 * progress;
        right.center = center
        
        if progress != 0 || progress != 1 {
            left.transform = largerTransformOfCenterX(center.x)
            right.transform = smallerTransformOfCenterX(center.x)
        } else {
            left.transform = CGAffineTransform.identity
            right.transform = CGAffineTransform.identity
        }
        
        centerV.frame = right.convert(right.bounds, to: left)
        centerV.layer.cornerRadius = centerV.jmWidth * 0.5
    }
    
    @objc func update() {
        SRLogger.error("update")
        if direction == .positive {
            var center = left.center
            center.x += 0.7
            left.center = center
            
            center = right.center
            center.x -= 0.7
            right.center = center
            
            left.transform = largerTransformOfCenterX(center.x)
            right.transform = smallerTransformOfCenterX(center.x)
            
            centerV.frame = right.convert(right.bounds, to: left)
            centerV.layer.cornerRadius = centerV.jmWidth * 0.5
            
            if left.frame.maxX >= content.jmWidth || right.frame.minX <= 0 {
                direction = .negatiove
                content.bringSubview(toFront: right)
                right.addSubview(centerV)
                reset()
            }
        } else if direction == .negatiove {
            var center = left.center
            center.x -= 0.7
            left.center = center
            
            center = right.center
            center.x += 0.7
            right.center = center
            
            left.transform = largerTransformOfCenterX(center.x)
            right.transform = smallerTransformOfCenterX(center.x)
            
            centerV.frame = left.convert(left.bounds, to: right)
            centerV.layer.cornerRadius = centerV.jmWidth * 0.5
            
            if left.frame.minX <= 0 || right.frame.maxX >= content.jmWidth {
                direction = .positive
                content.bringSubview(toFront: left)
                left.addSubview(centerV)
                reset()
            }
        }
    }
    
    // 放大动画
    func largerTransformOfCenterX(_ centerX: CGFloat) -> CGAffineTransform {
        let cosValue = cosValueOfCenterX(centerX)
        return CGAffineTransform(scaleX: 1 + cosValue * 0.25, y: 1 + cosValue * 0.25);
    }

    // 缩小动画
    func smallerTransformOfCenterX(_ centerX: CGFloat) -> CGAffineTransform {
        let cosValue = cosValueOfCenterX(centerX)
        return CGAffineTransform(scaleX: 1 - cosValue * 0.25, y: 1 - cosValue * 0.25);
    }

    func cosValueOfCenterX(_ centerX: CGFloat) -> CGFloat {
        // 移动距离
        let apart = centerX - content.bounds.size.width * 0.5
        // 最大距离(球心距离Container中心距离)
        let maxAppart = (content.bounds.size.width - 12) * 0.5
        // 移动距离和最大距离的比例
        let angle = apart / maxAppart * Double.pi/2;
        // 获取比例对应余弦曲线的Y值
        return cos(angle)
    }
    
    public override func layoutSubviews() {
        content.center = CGPoint(x: self.jmWidth * 0.5, y: self.jmHeight * 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}
