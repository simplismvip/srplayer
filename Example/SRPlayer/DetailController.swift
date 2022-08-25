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
    let player: SRPlayerController
    let request: SRMoreDataRequest
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    init(stype: SourceType) {
        let contain = [SourceType.home, SourceType.vod, SourceType.local].contains(stype)
        self.player = SRPlayerNormalController(contain ? .vod : .living)
        self.request = SRMoreDataRequest()
        super.init(nibName: nil, bundle: nil)
        self.type = stype
    }
    
    init(build: PlayerBulider) {
        self.player = SRPlayerNormalController(build.stream)
        self.request = SRMoreDataRequest()
        super.init(nibName: nil, bundle: nil)
        self.startPlay(build)
        self.type = .living
    }
    
    init(model: Model) {
        let contain = [SourceType.home, SourceType.vod, SourceType.local].contains(model.type)
        self.player = SRPlayerNormalController(contain ? .vod : .living)
        self.request = SRMoreDataRequest()
        super.init(nibName: nil, bundle: nil)
        self.type = model.type
        self.startPlay(model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        registerEvent()
        self.request.associatPlayer(self.player)
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
                self?.startPlay(m)
            }
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNamePausePlayDemoVideo, block: { [weak self] info in
            self?.player.jmSendMsg(msgName: kMsgNamePauseOrRePlay, info: nil)
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNameStopPlayDemoVideo, block: { [weak self] info in
            self?.player.jmSendMsg(msgName: kMsgNameStopPlaying, info: nil)
        }, next: false)
        
        jmRegisterEvent(eventName: kEventNamePopController, block: { [weak self] info in
            self?.navigationController?.popViewController(animated: true)
        }, next: false)
    }
    
    // 开始播放
    func startPlay(_ build: PlayerBulider) {
        // et url = URL(string: "/Users/jh/Desktop/dragon.mkv")
        player.jmSendMsg(msgName: kMsgNamePlayStartSetup, info: build as MsgObjc)
    }
    
    func startPlay(_ model: Model) {
        if model.type == .local {
            if let url = Bundle.main.url(forResource: model.url, withExtension: "MOV") {
                let video = PlayerBulider.Video(videoUrl: url, title: model.title, cover:  model.image, size: "720x1080")
                let build = PlayerBulider(video: video, streamType: .vod)
                player.jmSendMsg(msgName: kMsgNamePlayStartSetup, info: build as MsgObjc)
            }
        } else {
            if let url = URL(string: model.url) {
                let video = PlayerBulider.Video(videoUrl: url, title: model.title, cover:  model.image, size: "720x1080")
                let build = PlayerBulider(video: video, streamType: (model.type == .vod) ? .vod : .living)
                player.jmSendMsg(msgName: kMsgNamePlayStartSetup, info: build as MsgObjc)
            }
        }
    }
    
    deinit {
        JMLogger.error("类DetailController已经释放")
    }
}

extension DetailController {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
}


extension DetailController {
    override var shouldAutorotate: Bool {
        return true
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
//        JMLogger.debug(m.title)
    }
}
