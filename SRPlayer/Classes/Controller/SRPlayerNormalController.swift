//
//  SRPlayerNormalController.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//

import UIKit
import ZJMKit
import IJKMediaFrameworkWithSSL

public class SRPlayerNormalController: SRPlayerController {
//    var url: URL?
//    var player: IJKMediaPlayback?
    let processM: SRProgressManager
    let barManager: SRBarManager
    
    public override init(frame: CGRect) {
        self.barManager = SRBarManager()
        self.processM = SRProgressManager()
        super.init(frame: frame)
        progress()
        initEdgeItems()
        addEdgeSubViews()
    }
    
    public func smallPlayFrameReset() {
        let video = UIView()
        self.addPlayer(video)
    }
    
    public func config() {
//        #if DEBUG
//            IJKFFMoviePlayerController.setLogReport(true)
//            IJKFFMoviePlayerController.setLogLevel(k_IJK_LOG_DEBUG)
//        #else
//            IJKFFMoviePlayerController.setLogReport(false)
//            IJKFFMoviePlayerController.setLogLevel(k_IJK_LOG_INFO)
//        #endif
//        IJKFFMoviePlayerController.checkIfFFmpegVersionMatch(true)
//        let options = IJKFFOptions.byDefault()
//        player = IJKFFMoviePlayerController(contentURL: url, with: options)
//        player?.view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        player?.view?.frame = view.bounds
//        player?.scalingMode = .aspectFit
//        player?.shouldAutoplay = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRPlayerNormalController {
    func play() {
        jmSendMsg(msgName: kMsgNameStartPlay, info: nil)
    }
    
    func pause() {
        jmSendMsg(msgName: kMsgNameStartPlay, info: nil)
    }
    
    func stop() {
        jmSendMsg(msgName: kMsgNameStartPlay, info: nil)
    }
    
    func isPlaying() -> Bool {
        let progress: SRPlayProcess = self.processM.progress()!
        return progress.model.isPlaying
    }
    
    func mute() -> Bool {
        return false
    }
    
    func setMute(ismute: Bool) {
        
    }
}

extension SRPlayerNormalController {
    private func progress() {
        let playP = SRPlayProcess()
        let urlP = SRPlayUrlProgress()
        let switchP = SRQualitySwitchProcess()
        self.processM.updateProgress(playP)
        self.processM.updateProgress(urlP)
        self.processM.updateProgress(switchP)
    }
}
