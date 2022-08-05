//
//  SRMoreAreaView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class SRMoreAreaView: SRPierceView {
    public let content: UIView
    public var type: MoreEdgeType
    public var isShow: Bool
    override init(frame: CGRect) {
        self.content = UIView(frame: frame)
        self.type = .none
        self.isShow = false
        super.init(frame: frame)
        content.backgroundColor = UIColor.black.jmComponent(0.5)
        addSubview(content)
        content.snp.makeConstraints { make in
            make.right.height.top.equalTo(self)
            make.width.equalTo(120)
            // make.width.greaterThanOrEqualTo(CGFloat.leastNormalMagnitude)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRMoreAreaView: SRMoreArea { }
