//
//  MoreEdgeView.swift
//  SRPlayer
//
//  Created by jh on 2022/8/5.
//

import UIKit

public enum MoreEdgeType {
    case playrate
    case series
    case resolve
    case none
}

struct MoreItem {
    var title: String
    var image: String
    var type: MoreEdgeType
}

class MoreEdgeView: UIView, UITableViewDelegate, UITableViewDataSource {
    var items = [MoreItem]()
    let tableView: UITableView
    override init(frame: CGRect) {
        self.tableView = UITableView(frame: frame, style: .plain)
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.estimatedRowHeight = 50
        tableView.sectionHeaderHeight = 6
        tableView.sectionFooterHeight = 0
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MoreEdgeCell")
        if cell == nil {
            tableView.register(MoreEdgeCell.self, forCellReuseIdentifier: "MoreEdgeCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "MoreEdgeCell")
        }
        (cell as? MoreEdgeCell)?.refresh(items[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MoreEdgeCell: UITableViewCell {
    let cover = UIImageView()
    let title = UILabel()
    var item: MoreItem?
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
    
    func refresh(_ item: MoreItem) {
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
