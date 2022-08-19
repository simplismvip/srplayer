//
//  MoreEdgeView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/5.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

// More 切换剧集、视频质量、播放速率选择页面
public class MoreEdgeView: UIView, UITableViewDelegate, UITableViewDataSource {
    var items = [MoreEdgeItem]()
    let tableView: UITableView
    public let loading: SRLoading
    
    override init(frame: CGRect) {
        self.loading = SRLoading()
        self.tableView = UITableView(frame: frame, style: .plain)
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorInset = UIEdgeInsets.zero
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.left.width.equalTo(self)
        }
        
        loading.start()
        addSubview(loading)
        loading.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerY.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MoreEdgeCell")
        if cell == nil {
            tableView.register(MoreEdgeCell.self, forCellReuseIdentifier: "MoreEdgeCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "MoreEdgeCell")
        }
        (cell as? MoreEdgeCell)?.refresh(items[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if items.count * 44 < Int(jmHeight) {
            return jmHeight / CGFloat(items.count)
        }
        return 44
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        jmRouterEvent(eventName: item.event, info: item as MsgObjc)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class MoreEdgeCell: UITableViewCell {
        let cover = UIImageView()
        let title = UILabel()
        var item: MoreEdgeItem?
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            backgroundColor = UIColor.clear
            selectionStyle = .none
            contentView.addSubview(cover)
            contentView.addSubview(title)
            
            cover.contentMode = .scaleAspectFill
            cover.clipsToBounds = true
            cover.layer.cornerRadius = 8
            
            title.jmConfigLabel(font: UIFont.jmRegular(17), color: UIColor.white)
            layoutViews()
        }
        
        func refresh(_ item: MoreEdgeItem) {
            self.item = item
            title.text = item.title
            cover.alpha = 0
            cover.setimage(url: item.image) { [weak self] in
                UIView.animate(withDuration: 0.3) {
                    self?.cover.alpha = 1
                }
            }
        }
        
        private func layoutViews() {
            cover.snp.makeConstraints { (make) in
                make.height.equalTo(30)
                make.width.lessThanOrEqualTo(30)
                make.left.equalTo(self).offset(10)
                make.centerY.equalTo(self.snp.centerY)
            }
            
            title.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.snp.centerY)
                make.left.equalTo(cover.snp.right).offset(5)
                make.right.equalTo(self.snp.right).offset(-10)
                make.height.equalTo(30)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError(" implemented")
        }
    }
}

extension MoreEdgeView: SRMoreContent {
    public func reload(_ item: [MoreResult]) {
        self.items = item.flatMap({ $0.results })
        tableView.reloadData()
        hideLoading()
    }
}
