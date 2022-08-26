//
//  SRLoading.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

public class SRLoading: UIView {
    private let leftV = CAShapeLayer()
    private let centerV = CAShapeLayer()
    private let rightV = CAShapeLayer()
    private var r_radius: CGFloat = 6
    private let title = UILabel(frame: .zero)
    public var currType: ToastType
    
    override init(frame: CGRect) {
        self.currType = .loading
        super.init(frame: frame)
        
        layer.addSublayer(leftV)
        layer.addSublayer(centerV)
        layer.addSublayer(rightV)
        
        centerV.color(UIColor.white)
        rightV.color(UIColor.green)
        leftV.color(UIColor.red)
        title.jmConfigLabel(alig: .center, font: UIFont.jmRegular(10), color: UIColor.white)
        addSubview(title)
        title.text = "125 KB"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    
        let diameter = 2 * r_radius
        let cX = bounds.size.width/2
        let height = bounds.size.height
        
        let leftP = CGPoint(x: cX - diameter, y: r_radius)
        let rightP = CGPoint(x: cX + diameter, y: r_radius)

        leftV.frame = CGRect(x: leftP.x, y: 0, width: diameter, height: diameter)
        leftV.radius(r_radius)
        leftV.position(from: leftP, to: rightP, dutation: 0.6)
        leftV.scale(from: 0.6, to: 1, dutation: 0.6)
        
        rightV.frame = CGRect(x: cX + r_radius, y: 0, width: diameter, height: diameter)
        rightV.radius(r_radius)
        rightV.position(from: rightP, to: leftP, dutation: 0.6)
        rightV.scale(from: 1, to: 0.6, dutation: 0.6)
        
        centerV.frame = CGRect(x: cX - r_radius, y: 0, width: diameter, height: diameter)
        centerV.radius(r_radius)
        centerV.scale(from: 0.8, to: 0.4, dutation: 0.3)
        
        title.frame = CGRect(x: 0, y: centerV.frame.maxY, width: bounds.size.width, height: height - diameter)
    }
    
    func stop() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    func start() { }
    
    deinit {
        JMLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}

extension SRLoading: FloatToast {
    public func update(_ type: ToastType) {
        switch type {
        case .netSpeed(let string):
            title.text = string
        default:
            title.text = ""
        }
    }
    
    public func begin(_ type: ToastType) {
        self.currType = type
        start()
    }
    
    func hide() {
        stop()
    }
}

extension UIView {
    func loadingConfig(_ color: UIColor) {
        layer.cornerRadius = 6
        layer.masksToBounds = true;
        backgroundColor = color
    }
}
