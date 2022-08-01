//
//  SRBkgView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRBkgView: UIView {
    let text: UILabel
    let imageView: UIImageView
    public override init(frame: CGRect) {
        text = UILabel()
        imageView = UIImageView()
        super.init(frame: frame)
        text.text = "准备播放。。。"
        text.font = UIFont.jmRegular(20)
        text.textColor = UIColor.white
        backgroundColor = UIColor.black.jmComponent(0.2)
        
        addSubview(imageView)
        imageView.snp.makeConstraints { $0.edges.equalTo(self) }
        
        addSubview(text)
        text.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(40)
        }
    }
    
    func startPlay() {
        text.isHidden = true
        backgroundColor = nil
    }
    
    func endPlay() {
        text.isHidden = false
        text.text = "播放完成✅。。。"
        backgroundColor = UIColor.black.jmComponent(0.2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
