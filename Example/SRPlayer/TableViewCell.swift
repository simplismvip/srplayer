//
//  TableViewCell.swift
//  SRPlayer_Example
//
//  Created by JunMing on 2022/7/17.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit
import SnapKit

class TableViewCell: UITableViewCell {
    let title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        addSubview(title)
        title.jmConfigLabel(font: UIFont.jmRegular(18), color: UIColor.black)
        selectionStyle = .none
        title.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(20)
            make.top.height.equalTo(self)
        }
    }
    
    func refresh(_ model: Model) {
        title.text = model.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(" implemented")
    }
}

class DetailViewCell: UITableViewCell {
    let cover = UIImageView()
    let playBtn = UIButton(type: .system)
    let title = UILabel()
    var model: Model?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        selectionStyle = .none
        contentView.addSubview(cover)
        contentView.addSubview(title)
        contentView.addSubview(playBtn)
        
        cover.contentMode = .scaleAspectFill
        cover.clipsToBounds = true
        playBtn.setImage("sr_play".image, for: .normal)
        playBtn.tintColor = UIColor.white
        title.jmConfigLabel(font: UIFont.jmRegular(20), color: UIColor.white)
        layoutViews()
        playBtn.jmAddAction { [weak self] _ in
            self?.jmRouterEvent(eventName: "kEventNameStartPlayDemoVideo", info: self?.model as MsgObjc)
        }
    }
    
    func refresh(_ model: Model) {
        self.model = model
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

