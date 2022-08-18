//
//  SRNotification.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/3.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

enum Noti {
    case loadChange
    case playbackFinish
    case isPrepared
    case stateChange
    case willChangeStatusBar
    case didChangeStatusBar
    case enterBackground
    case becomeActive
    case battery
    
    var name: NSNotification.Name {
        switch self {
        case .loadChange:
            return NSNotification.Name.IJKMPMoviePlayerLoadStateDidChange
        case .playbackFinish:
            return NSNotification.Name.IJKMPMoviePlayerPlaybackDidFinish
        case .isPrepared:
            return NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange
        case .stateChange:
            return NSNotification.Name.IJKMPMoviePlayerPlaybackStateDidChange
        case .willChangeStatusBar:
            return UIApplication.willChangeStatusBarOrientationNotification
        case .didChangeStatusBar:
            return UIApplication.didChangeStatusBarOrientationNotification
        case .enterBackground:
            return UIApplication.didEnterBackgroundNotification
        case .becomeActive:
            return UIApplication.didBecomeActiveNotification
        case .battery:
            return UIDevice.batteryLevelDidChangeNotification
        }
    }
}
