//
//  SRPlayerNormalController.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//

import UIKit
import IJKMediaFrameworkWithSSL

class SRPlayerNormalController: SRPlayerController {
    var url: URL?
    var player: IJKMediaPlayback?
    
    func smallPlayFrameReset() {
        let video = UIView()
        self.addPlayer(video)
    }
    
    func config() {
        #if DEBUG
            IJKFFMoviePlayerController.setLogReport(true)
            IJKFFMoviePlayerController.setLogLevel(k_IJK_LOG_DEBUG)
        #else
            IJKFFMoviePlayerController.setLogReport(false)
            IJKFFMoviePlayerController.setLogLevel(k_IJK_LOG_INFO)
        #endif
        IJKFFMoviePlayerController.checkIfFFmpegVersionMatch(true)
        let options = IJKFFOptions.byDefault()
        player = IJKFFMoviePlayerController(contentURL: url, with: options)
        player?.view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        player?.view?.frame = view.bounds
        player?.scalingMode = .aspectFit
        player?.shouldAutoplay = true
    }
}
