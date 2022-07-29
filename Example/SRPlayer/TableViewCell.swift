//
//  TableViewCell.swift
//  SRPlayer_Example
//
//  Created by JunMing on 2022/7/17.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import ZJMKit
import SnapKit

class TableViewCell: UITableViewCell {
    let cover = UIImageView()
    let playBtn = UIButton(type: .system)
    let title = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        
        contentView.addSubview(cover)
        contentView.addSubview(title)
        contentView.addSubview(playBtn)
        
        cover.contentMode = .scaleAspectFill
        cover.clipsToBounds = true
        playBtn.setImage("sr_play".image, for: .normal)
        playBtn.tintColor = UIColor.white
        title.jmConfigLabel(font: UIFont.jmRegular(20), color: UIColor.white)
        layoutViews()
    }
    
    func refresh(_ model: Model) {
        title.text = model.title
        cover.setImage(url: model.image, complate: nil)
    }
    
    private func layoutViews() {
        cover.snp.makeConstraints { (make) in
            make.top.left.width.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-8)
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(34)
        }
        
        playBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.height.width.equalTo(84)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(" implemented")
    }
}

