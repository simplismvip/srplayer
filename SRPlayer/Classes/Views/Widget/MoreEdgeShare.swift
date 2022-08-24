//
//  MoreEdgeShare.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/10.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

class MoreEdgeShare: UIView {
    let loading: SRLoading
    
    override init(frame: CGRect) {
        self.loading = SRLoading()
        super.init(frame: frame)
        
        loading.start()
        addSubview(loading)
        loading.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerY.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoreEdgeShare: SRMoreContent {
    public func reload(_ item: [MoreResult]) {
//        self.items = items
//        tableView.reloadData()
//        hideLoading()
    }
}
