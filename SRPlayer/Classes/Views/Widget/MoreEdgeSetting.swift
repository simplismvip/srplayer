//
//  MoreEdgeSetting.swift
//  SRPlayer
//
//  Created by jh on 2022/8/10.
//

import UIKit

class MoreEdgeSetting: UIView {
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

extension MoreEdgeSetting: SRMoreContent {
    public func reload(_ type: MoreEdgeType) {
        switch type {
        case .more(let result):
            SRLogger.debug(result?.count)
//            self.items = items
//            tableView.reloadData()
//            hideLoading()
        default:
            SRLogger.debug("none")
        }
    }
}
