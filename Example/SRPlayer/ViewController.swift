//
//  ViewController.swift
//  SRPlayer
//
//  Created by JunMing on 07/13/2022.
//  Copyright (c) 2022 JunMing. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var dataSource = [Model]()
    var type: VideoType = .home
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
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
        if let results = DataTool<Results>.decode(type.name)?.results {
            dataSource.append(contentsOf: results)
        }
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
    
    @IBAction func testAction(_ sender: Any) {
        navigationController?.pushViewController(TestController(), animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        if cell == nil {
            tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        }
        (cell as? TableViewCell)?.refresh(dataSource[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailController(dataSource[indexPath.row].type), animated: true)
    }
}
