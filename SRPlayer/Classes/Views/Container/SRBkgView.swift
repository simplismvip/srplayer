//
//  SRBkgView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRBkgView: SRPierceView {
    private let imageView: UIImageView
    public override init(frame: CGRect) {
        imageView = UIImageView()
//        imageView.isUserInteractionEnabled = true
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.snp.makeConstraints { $0.edges.equalTo(self) }
        imageView.image = "sr_1_background".image
    }
    
    func startPlay() {
        imageView.isHidden = true
    }
    
    func endPlay() {
        imageView.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRBkgView: SRBackground {
    
}
