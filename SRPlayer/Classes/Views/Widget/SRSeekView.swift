//
//  SRSeekView.swift
//  SRPlayer
//
//  Created by jh on 2022/8/4.
//

import UIKit

class SRSeekView: UIView {
    private let image: UIButton
    private let slider: SRPlayerSlider
    
    override init(frame: CGRect) {
        self.slider = SRPlayerSlider()
        self.image = UIButton(type: .system)
        super.init(frame: frame)
        addSubview(image)
        addSubview(slider)
//        slider.thumbImage
        image.isUserInteractionEnabled = false
        image.tintColor = UIColor.white
        
        slider.minTrackTintColor = UIColor.white
        slider.maxTrackTintColor = UIColor.gray
        slider.thumbImageView.isHidden = true
        
        image.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(self).offset(10)
        }
        
        slider.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(5)
            make.right.equalTo(snp.right).offset(-10)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(20)
        }
    }
    
    func floatType(_ type: FloatType) {
        image.setImage(type.name.image, for: .normal)
    }
    
    func update(_ progress: CGFloat) {
        slider.updateValue(progress)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
