//
//  MoreEdgeSeries.swift
//  SRPlayer
//
//  Created by jh on 2022/8/10.
//

import UIKit
import ZJMKit

// More 剧集选择页面
class MoreEdgeSeries: UIView, UITableViewDelegate, UITableViewDataSource {
    var items = [MoreEdgeItem]()
    let tableView: UITableView
    let loading: SRLoading
    
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
            make.edges.equalTo(self)
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
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

}

extension MoreEdgeSeries: SRMoreContent {
    public func reload(_ item: [Results]) {
//        self.items = result?.results
//        tableView.reloadData()
//        hideLoading()
    }
}
