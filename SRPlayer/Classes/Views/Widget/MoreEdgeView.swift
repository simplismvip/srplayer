//
//  MoreEdgeView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/5.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public class MoreEdgeView: UIView, UITableViewDelegate, UITableViewDataSource {
    var items = [MoreEdgeItem]()
    let tableView: UITableView
    let loading: SRLoading
    override init(frame: CGRect) {
        self.loading = SRLoading()
        self.tableView = UITableView(frame: frame, style: .plain)
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets.zero
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        addSubview(loading)
        loading.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.centerY.equalTo(snp.centerY)
            make.centerX.equalTo(snp.centerX)
        }
    }
    
    public func reload(_ type: MoreEdgeType) {
        switch type {
        case .playrate:
            if let items = DataParser<Results>.decode(type.name, "json")?.results {
                self.items = items
                tableView.reloadData()
            }
        case .series, .resolve:
            loading.start()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let items = DataParser<Results>.decode(type.name, "json")?.results {
                    self.items = items
                    self.tableView.reloadData()
                }
                self.loading.stop()
            }
//            DataParser<Results>.request(path: type.name) { result in
//                if let items = result?.results {
//                    self.items = items
//                    self.tableView.reloadData()
//                } else {
//                    SRLogger.debug("请求失败请重试")
//                }
//                self.loading.stop()
//            }
        case .none:
            SRLogger.debug("none")
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
    
    private func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MoreEdgeCell: UITableViewCell {
    let cover = UIImageView()
    let title = UILabel()
    var item: MoreEdgeItem?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        
        contentView.addSubview(cover)
        contentView.addSubview(title)
        
        cover.contentMode = .scaleAspectFill
        cover.clipsToBounds = true
        
        title.jmConfigLabel(font: UIFont.jmRegular(20), color: UIColor.white)
        layoutViews()
    }
    
    func refresh(_ item: MoreEdgeItem) {
        self.item = item
        title.text = item.title
        cover.image = item.image.image
    }
    
    private func layoutViews() {
        cover.snp.makeConstraints { (make) in
            make.height.width.equalTo(36)
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        title.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(cover.snp.right).offset(5)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(36)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(" implemented")
    }
}
