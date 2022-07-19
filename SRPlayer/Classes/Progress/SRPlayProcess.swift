//
//  SRPlayProcess.swift
//  Pods-SRPlayer_Example
//
//  Created by jh on 2022/7/18.
//

import UIKit
import ZJMKit
import IJKMediaFrameworkWithSSL

class SRPlayProcess: NSObject {
    var model: SRPlayModel
    var player: IJKMediaPlayback?
    override init() {
        self.model = SRPlayModel()
    }
    
    func setupPlayer(url: String) {
        player = IJKFFMoviePlayerController(contentURL: URL(string: url)!, with: options())
        player?.view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        player?.scalingMode = .aspectFit
        player?.shouldAutoplay = true
    }

    func options() -> IJKFFOptions {
        let options = IJKFFOptions()
        options.setPlayerOptionIntValue(30, forKey: "max-fps")
        options.setPlayerOptionIntValue(30, forKey:"r")
        // 跳帧开关
        options.setPlayerOptionIntValue(1, forKey:"framedrop")
        options.setPlayerOptionIntValue(0, forKey:"start-on-prepared")
        options.setPlayerOptionIntValue(0, forKey:"http-detect-range-support")
        options.setPlayerOptionIntValue(48, forKey:"skip_loop_filter")
        options.setPlayerOptionIntValue(0, forKey:"packet-buffering")
        options.setPlayerOptionIntValue(2000000, forKey:"analyzeduration")
        options.setPlayerOptionIntValue(25, forKey:"min-frames")
        options.setPlayerOptionIntValue(1, forKey:"start-on-prepared")
        options.setCodecOptionIntValue(8, forKey:"skip_frame")
        options.setPlayerOptionValue("nobuffer", forKey: "fflags")
        options.setPlayerOptionValue("8192", forKey: "probsize")
        // 自动转屏开关
        options.setFormatOptionIntValue(0, forKey:"auto_convert")
        // 重连次数
        options.setFormatOptionIntValue(1, forKey:"reconnect")
        // 开启硬解码
        options.setPlayerOptionIntValue(1, forKey:"videotoolbox")
        return options
    }
    
    private func addObserve(select: Selector, name: Noti) {
        NotificationCenter.default.addObserver(self, selector: select, name: name.name, object: player)
    }
    
    private func remove(_ name: Noti) {
        NotificationCenter.default.removeObserver(self, name: name.name, object: player)
    }
    
    enum Noti {
        case change
        case finish
        case isPrepared
        case stateChange
        
        var name: NSNotification.Name {
            switch self {
            case .change:
                return NSNotification.Name.IJKMPMoviePlayerLoadStateDidChange
            case .finish:
                return NSNotification.Name.IJKMPMoviePlayerPlaybackDidFinish
            case .isPrepared:
                return NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange
            case .stateChange:
                return NSNotification.Name.IJKMPMoviePlayerPlaybackStateDidChange
            }
        }
    }
}

extension SRPlayProcess: SRProgress {
    func configProcess() {
        /// 开始播放
        jmReciverMsg(msgName: kMsgNameStartPlay) { _ in
            return nil
        }
        
        /// 停止播放
        jmReciverMsg(msgName: kMsgNameStopPlay) { _ in
            
            return nil
        }
        
        /// 暂停播放
        jmReciverMsg(msgName: kMsgNamePausePlay) { _ in
            
            return nil
        }
        
        /// 播放
        jmReciverMsg(msgName: kMsgNameActionPlay) { _ in
            
            return nil
        }
        
        /// 快进快退
        jmReciverMsg(msgName: kMsgNameActionSeekTo) { _ in
            
            return nil
        }
        
        /// 切换清晰度
        jmReciverMsg(msgName: kMsgNameSwitchQuality) { _ in
            
            return nil
        }
        
        /// 静音
        jmReciverMsg(msgName: kMsgNameActionMute) { _ in
            
            return nil
        }
        
        /// 更改播放速率
        jmReciverMsg(msgName: kMsgNameChangePlaybackRate) { _ in
            
            return nil
        }
        
        /// 更改放缩比例
        jmReciverMsg(msgName: kMsgNameChangeScalingMode) { _ in
            
            return nil
        }
        
        /// 截图
        jmReciverMsg(msgName: kMsgNameShotScreen) { _ in
            
            return nil
        }
    }
}

extension SRPlayProcess {
    
    @objc func loadStateDidChange(_ notification: Notification) {
        if let loadState = player?.loadState {
            if loadState.contains(.playthroughOK) {
                print("loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: \(loadState)\n")
            } else if loadState.contains(.stalled) {
                print("loadStateDidChange: IJKMPMovieLoadStateStalled: \(loadState)\n")
            } else {
                print("loadStateDidChange: ???: \(loadState)\n")
            }
        }
    }
    
    @objc func moviePlayBackDidFinish(_ notification: Notification) {
        let reason = notification.userInfo?[IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as! Int
        switch reason {
        case IJKMPMovieFinishReason.playbackEnded.rawValue:
            print("playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: \(reason)\n")
        case IJKMPMovieFinishReason.userExited.rawValue:
            print("playbackStateDidChange: IJKMPMovieFinishReasonUserExited: \(reason)\n")
        case IJKMPMovieFinishReason.playbackError.rawValue:
            print("playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: \(reason)\n")
        default:
            print("playbackPlayBackDidFinish: ???: \(reason)\n")
        }
        
    }
    
    @objc func mediaIsPreparedToPlayDidChange(notification: Notification) {
        print("mediaIsPreparedToPlayDidChange\n")
    }
    
    @objc func moviePlayBackStateDidChange(_ notification: Notification) {
        guard player != nil else {
            return
        }
        switch player!.playbackState {
        case .stopped:
            print("IJKMPMoviePlayBackStateDidChange \(String(describing: player?.playbackState)): stoped")
            break
        case .playing:
            print("IJKMPMoviePlayBackStateDidChange \(String(describing: player?.playbackState)): playing")
            break
        case .paused:
            print("IJKMPMoviePlayBackStateDidChange \(String(describing: player?.playbackState)): paused")
            break
        case .interrupted:
            print("IJKMPMoviePlayBackStateDidChange \(String(describing: player?.playbackState)): interrupted")
            break
        case .seekingForward, .seekingBackward:
            print("IJKMPMoviePlayBackStateDidChange \(String(describing: player?.playbackState)): seeking")
            break
        }
    }
    
    func removeObserver() {
        [Noti.change, Noti.finish, Noti.isPrepared, Noti.stateChange].forEach {
            remove($0)
        }
    }
    
    func installObserver() {
        addObserve(select: #selector(self.loadStateDidChange), name: .change)
        addObserve(select: #selector(self.moviePlayBackDidFinish), name: .finish)
        addObserve(select: #selector(self.mediaIsPreparedToPlayDidChange), name: .isPrepared)
        addObserve(select: #selector(self.moviePlayBackStateDidChange), name: .stateChange)
    }
}
