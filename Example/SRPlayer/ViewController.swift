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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let results = DataTool<Results>.decode("urls")?.results {
            dataSource.append(contentsOf: results)
        }
        
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
        
        jmRegisterEvent(eventName: kEventNameStartPlayDemoVideo, block: { [weak self] model in
            if let m = model as? Model {
                if m.type == .local {
                    if let url = Bundle.main.url(forResource: m.url, withExtension: "MOV") {
                        let urlmkv = URL(fileURLWithPath: "/Users/jl/Desktop/000002.mkv")
                        let build = PlayerBulider(url: urlmkv)
                        self?.player.jmSendMsg(msgName: kMsgNamePlayStartSetup, info: build as MsgObjc)
                    }
                } else {
                    if let url = URL(string: m.url) {
                        let build = PlayerBulider(url: url)
                        self?.player.jmSendMsg(msgName: kMsgNamePlayStartSetup, info: build as MsgObjc)
                    }
                }
                SRLogger.debug(m.title)
            }
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNamePausePlayDemoVideo, block: { [weak self] info in
            self?.player.jmSendMsg(msgName: kMsgNamePauseOrRePlay, info: nil)
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNameStopPlayDemoVideo, block: { [weak self] info in
            self?.player.jmSendMsg(msgName: kMsgNameStopPlay, info: nil)
        }, next: false)
    }
    
    @IBAction func testAction(_ sender: Any) {
        navigationController?.pushViewController(SecondController(), animated: true)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    override var shouldAutorotate: Bool {    
        return false
    }
}

class SecondController :UIViewController {
    let v = SRLoading()
    let b = SRBatteryView()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        v.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        b.backgroundColor = UIColor.green
        self.view.addSubview(b)
        b.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(12)
            make.top.equalTo(view.snp.top).offset(100)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        self.view.addSubview(v)
        v.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerY.equalTo(view.snp.centerY)
            make.centerX.equalTo(view.snp.centerX)
        }
        v.start()
    }
}
