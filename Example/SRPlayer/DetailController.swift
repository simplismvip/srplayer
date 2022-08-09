//
//  DetailController.swift
//  SRPlayer_Example
//
//  Created by JunMing on 2022/8/4.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit
import SnapKit
import SRPlayer

class DetailController: ViewController {
    let player: SRPlayerNormalController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    init(_ type: VideoType) {
        self.player = SRPlayerNormalController()
        super.init(nibName: nil, bundle: nil)
        self.type = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        registerEvent()
    }
    
    override func setupViews() {
        super.setupViews()
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

        tableView.snp.remakeConstraints { make in
            make.left.width.equalTo(view)
            make.top.equalTo(player.snp.bottom)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalTo(view.snp.bottom)
            }
        }
    }
    
    func registerEvent() {
        jmRegisterEvent(eventName: kEventNameStartPlayDemoVideo, block: { [weak self] model in
            if let m = model as? Model {
                if m.type == .local {
                    if let url = Bundle.main.url(forResource: m.url, withExtension: "MOV") {
                        let video = PlayerBulider.Video(videoUrl: url, title: m.title, cover:  m.image, resolution: "720x1080")
                        let build = PlayerBulider(video: video)
                        self?.player.jmSendMsg(msgName: kMsgNamePlayStartSetup, info: build as MsgObjc)
                    }
                } else {
                    if let url = URL(string: m.url) {
                        let video = PlayerBulider.Video(videoUrl: url, title: m.title, cover:  m.image, resolution: "720x1080")
                        let build = PlayerBulider(video: video)
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
        
        jmRegisterEvent(eventName: kEventNamePopController, block: { [weak self] info in
            self?.navigationController?.popViewController(animated: true)
        }, next: false)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "DetailViewCell")
        if cell == nil {
            tableView.register(DetailViewCell.self, forCellReuseIdentifier: "DetailViewCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "DetailViewCell")
        }
        (cell as? DetailViewCell)?.refresh(dataSource[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func test() {
//        if m.type == .local {
//            guard let url = Bundle.main.url(forResource: m.url, withExtension: "MOV") else {
//                return
//            }
//
//            guard let data = DataParser<Model>.encode(m)?.data else {
//                return
//            }
//
//            guard let video = DataParser<PlayerBulider.Video>.parser(data) else {
//                return
//            }
//
//            let build = PlayerBulider(video: video)
//            self?.player.jmSendMsg(msgName: kMsgNamePlayStartSetup, info: build as MsgObjc)
//
//        } else {
//            guard let data = DataParser<Model>.encode(m)?.data else {
//                return
//            }
//
//            guard let video = DataParser<PlayerBulider.Video>.parser(data) else {
//                return
//            }
//
//            let build = PlayerBulider(video: video)
//            self?.player.jmSendMsg(msgName: kMsgNamePlayStartSetup, info: build as MsgObjc)
//        }
//        SRLogger.debug(m.title)
    }
    
    deinit {
        SRLogger.error("类DetailController已经释放")
    }
}

extension DetailController {
    override var shouldAutorotate: Bool {
        return false
    }
}
