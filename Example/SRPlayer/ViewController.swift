//
//  ViewController.swift
//  SRPlayer
//
//  Created by JunMing on 07/13/2022.
//  Copyright (c) 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit
import SRPlayer
import SnapKit

class ViewController: UIViewController {
    var dataSource = [Model]()
    var type: SourceType = .home
    
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
        if let results = DataParser<Results>.decode(name: type.name, bundle: .main)?.results {
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
        jmShowAlert("在线视频", nil, "输入视频URL") { urlStr in
            if let urlStr = urlStr, let url = URL(string: urlStr), self.checkout(url.scheme) {
                let video = PlayerBulider.Video(videoUrl: url, title: url.lastPathComponent, cover: "", size: "720x1080")
                let build = PlayerBulider(video: video, streamType: .vod)
                let dcv = DetailController(build: build)
                self.navigationController?.pushViewController(dcv, animated: true)
            } else {
                JMTextToast.share.jmShowString(text: "输入地址错误", seconds: 1)
                JMLogger.error("输入地址错误：\(String(describing: urlStr))")
            }
        }
        // navigationController?.pushViewController(TestController(), animated: true)
    }
    
    func checkout(_ scheme: String?) -> Bool {
        return ["rtsp", "rtsp", "http"].contains(scheme)
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
        if let model = DataParser<Results>.decode(name: dataSource[indexPath.row].type.name, bundle: .main)?.results.first {
            let dcv = DetailController(model: model)
            navigationController?.pushViewController(dcv, animated: true)
        }
    }
}
