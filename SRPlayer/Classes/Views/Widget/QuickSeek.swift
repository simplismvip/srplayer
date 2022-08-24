//
//  QuickSeek.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/11.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class QuickSeek: UIView, Toast {
    private let image: UIImageView
    private let title: UILabel
    private let right: SRPlayerSlider
    
    override init(frame: CGRect) {
        self.image = UIImageView()
        self.right = SRPlayerSlider()
        self.title = UILabel()
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
        image.image = type.name.image
        title.text = "00:00/00:00"
    }
    
    func update(_ progress: CGFloat, text: String?) {
        right.updateValue(CGFloat(fabsf(Float(progress))))
        title.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
