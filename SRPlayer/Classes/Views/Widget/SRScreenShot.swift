//
//  SRScreenShot.swift
//  SRPlayer
//
//  Created by jh on 2022/8/9.
//

import UIKit
import ZJMKit
import Accelerate

class SRScreenShot: UIView {
    public let title: UILabel
    public let image: UIImageView
    public var currType: ToastType
    override init(frame: CGRect) {
        self.title = UILabel(frame: .zero)
        self.image = UIImageView(frame: .zero)
        self.currType = .screenShot(.zero, UIImage())
        super.init(frame: frame)
        backgroundColor = UIColor.black.jmComponent(0.6)
        layer.cornerRadius = 6
        layer.masksToBounds = true
        addSubview(title)
        addSubview(image)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        image.snp.makeConstraints { make in
            make.top.left.equalTo(self).offset(8)
            make.right.equalTo(self.snp.right).offset(-8)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
        title.jmConfigLabel(alig: .center, font: UIFont.jmRegular(10), color: UIColor.white)
        title.snp.makeConstraints { make in
            make.left.right.equalTo(image)
            make.top.equalTo(image.snp.bottom).offset(3)
            make.bottom.equalTo(snp.bottom).offset(-3)
        }
        
        jmAddblock { [weak self] in
            self?.jmRouterEvent(eventName: "", info: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRScreenShot: Toast {
    
    
    func begin(_ type: ToastType) {
        self.currType = type
        switch type {
        case .screenShot(_, let image):
            self.image.image = image
            self.title.text = "点击分享图片"
        default:
            JMLogger.debug("")
        }
    }
    
    func update(_ update: FloatParma) { }
}
