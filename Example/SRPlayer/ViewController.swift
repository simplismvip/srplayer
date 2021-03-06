//
//  ViewController.swift
//  SRPlayer
//
//  Created by simplismvip on 07/13/2022.
//  Copyright (c) 2022 simplismvip. All rights reserved.
//

import UIKit
import ZJMKit
import SnapKit
import SRPlayer

class ViewController: UIViewController {
    let player = SRPlayerNormalController()
    var dataSource = [Model]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.estimatedRowHeight = 50
        tableView.sectionHeaderHeight = 6
        tableView.sectionFooterHeight = 0
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let results = DataTool<Results>.decode("urls")?.results {
            dataSource.append(contentsOf: results)
        }
        
        title = "播放列表"
        
        view.addSubview(player)
        player.snp.makeConstraints { make in
            make.left.width.equalTo(view)
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalTo(view.snp.top)
            }
            make.height.equalTo(view.jmWidth * 0.56)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.width.equalTo(view)
            make.top.equalTo(player.snp.bottom)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalTo(view.snp.bottom)
            }
        }
    }
    
    @IBAction func testAction(_ sender: Any) {
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        if cell == nil {
            cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        }
        (cell as? TableViewCell)?.refresh(dataSource[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        if model.type == .local {
            if let url = Bundle.main.url(forResource: model.url, withExtension: "MOV") {
                let build = PlayerBulider(url: url)
                player.jmSendMsg(msgName: kMsgNameStartPlay, info: build as MsgObjc)
            }
        } else {
            if let url = URL(string: model.url) {
                let build = PlayerBulider(url: url)
                player.jmSendMsg(msgName: kMsgNameStartPlay, info: build as MsgObjc)
            }
        }
        SRLogger.debug(model.title)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
