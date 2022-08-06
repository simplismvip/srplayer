//
//  SRSeekView.swift
//  SRPlayer
//
//  Created by jh on 2022/8/4.
//

import UIKit

class ToastView<T: ToastRight>: UIView, Toast {
    private let image: UIButton
    private let right: T
    init(frame: CGRect, right: T) {
        self.image = UIButton()
        self.right = right
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.jmComponent(0.3)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        image.isUserInteractionEnabled = false
        image.tintColor = UIColor.white
        
        addSubview(image)
        addSubview(right)
        image.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(self).offset(10)
        }
        
        right.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(5)
            make.right.equalTo(snp.right).offset(-10)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(20)
        }
    }
    
    func begin(_ type: ToastType) {
        image.setImage(type.name.image, for: .normal)
    }
    
    func update(_ progress: CGFloat) {
        right.update(progress)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ToastView where T: SRPlayerSlider {
    func configSlider() {
        self.right.minTrackTintColor = UIColor.white
        self.right.maxTrackTintColor = UIColor.gray
        self.right.thumbImageView.isHidden = true
    }
}

extension ToastView where T: UILabel {
    func configText() {
        self.right.text = "2X播放"
    }
}

extension UILabel: ToastRight {
    func update(_ progress: CGFloat) { }
}
