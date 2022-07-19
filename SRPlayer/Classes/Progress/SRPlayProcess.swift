//
//  SRPlayProcess.swift
//  Pods-SRPlayer_Example
//
//  Created by jh on 2022/7/18.
//

import UIKit
import ZJMKit

class SRPlayProcess: NSObject, SRProgressP {
    var model: SRPlayModel
    override init() {
        self.model = SRPlayModel()
    }
    
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
    
}
