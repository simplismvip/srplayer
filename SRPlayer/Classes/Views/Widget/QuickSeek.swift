//
//  QuickSeek.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/11.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

class QuickSeek: UIView, FloatToast {
    public var currType: ToastType
    private let image: UIImageView
    private let title: UILabel
    private let right: SRPlayerSlider
    
    override init(frame: CGRect) {
        self.image = UIImageView()
        self.right = SRPlayerSlider()
        self.title = UILabel()
        self.currType = .seek(0.0, "")
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.jmComponent(0.5)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(image)
        addSubview(right)
        addSubview(title)
        
        image.snp.makeConstraints { make in
            make.width.height.equalTo(37)
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(self).offset(3)
        }
        
        right.minTrackTintColor = UIColor.white
        right.maxTrackTintColor = UIColor.gray
        right.thumbImageView.isHidden = true
        right.snp.makeConstraints { make in
            make.left.equalTo(self).offset(8)
            make.right.equalTo(snp.right).offset(-8)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(25)
            make.top.equalTo(image.snp.bottom).offset(-8)
        }
        
        title.jmConfigLabel(alig: .center, font: UIFont.jmRegular(14), color: UIColor.white)
        title.snp.makeConstraints { make in
            make.left.right.equalTo(right)
            make.height.equalTo(15)
            make.top.equalTo(right.snp.bottom)
        }
    }
    
    func begin(_ type: ToastType) {
        self.currType = type
        image.image = type.name.image
        title.text = "00:00/00:00"
    }
    
    public func update(_ type: ToastType) {
        switch type {
        case .seek(let value, let text):
            right.updateValue(CGFloat(fabsf(value)))
            title.text = text
        default:
            JMLogger.debug("")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class QuickAction: UIView, FloatToast {
    public var currType: ToastType
    private let action: UIButton
    private var seekTo: Double?
    override init(frame: CGRect) {
        self.action = UIButton(type: .system)
        self.currType = .seekAction(0, "")
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.jmComponent(0.5)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        action.setTitleColor(UIColor.white, for: .normal)
        action.titleLabel?.font = UIFont.jmRegular(12)
        
        addSubview(action)
        action.snp.makeConstraints { make in
            make.top.height.equalTo(self)
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
        }
        
        action.jmAddAction { [weak self] _ in
            self?.jmRouterEvent(eventName: kEventNameActionSeekToPlayTime, info: self?.seekTo as MsgObjc)
        }
    }
    
    func begin(_ type: ToastType) {
        self.currType = type
    }
    
    func update(_ type: ToastType) {
        switch type {
        case .seekAction(let value, let text):
            seekTo = Double(value)
            action.setTitle(text, for: .normal)
        default:
            JMLogger.debug("")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

