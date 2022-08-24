//
//  SRSeekView.swift
//  SRPlayer
//
//  Created by jh on 2022/8/4.
//

import UIKit

class ToastView<T: ToastRight>: UIView, Toast {
    public var currType: ToastType
    private let image: UIButton
    private let right: T
    init(frame: CGRect, right: T) {
        self.image = UIButton()
        self.right = right
        self.currType = .none
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.jmComponent(0.5)
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        image.isUserInteractionEnabled = false
        image.tintColor = UIColor.white
        
        addSubview(image)
        addSubview(right)
        image.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(self).offset(8)
        }
        
        right.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right)
            make.right.equalTo(snp.right).offset(-8)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(20)
        }
    }
    
    func begin(_ type: ToastType) {
        currType = type
        image.setImage(type.name.image, for: .normal)
    }
    
    func update(_ update: FloatParma) {
        right.update(update.progress)
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
        self.right.jmConfigLabel(alig: .center ,font: UIFont.jmRegular(13), color: UIColor.white)
        self.image.setImage("sr_forward".image, for: .normal)
    }
}

extension UILabel: ToastRight {
    func update(_ progress: CGFloat) { }
}
