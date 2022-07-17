//
//  ViewController.swift
//  SRPlayer
//
//  Created by simplismvip on 07/13/2022.
//  Copyright (c) 2022 simplismvip. All rights reserved.
//

import UIKit
import SnapKit
import SRPlayer

class ViewController: UIViewController {
    let player = SRPlayerController()
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
        
        title = "我的收藏"
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
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
        SRLogger.debug(model.title)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
