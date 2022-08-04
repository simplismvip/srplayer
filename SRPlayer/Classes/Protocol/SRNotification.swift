//
//  SRNotification.swift
//  SRPlayer
//
//  Created by jh on 2022/8/3.
//

import UIKit

enum Noti {
    case change
    case finish
    case isPrepared
    case stateChange
    case willChangeStatusBar
    case didChangeStatusBar
    case enterBackground
    case becomeActive
    case battery
    
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
        case .willChangeStatusBar:
            return NSNotification.Name.UIApplicationWillChangeStatusBarOrientation
        case .didChangeStatusBar:
            return NSNotification.Name.UIApplicationDidChangeStatusBarOrientation
        case .enterBackground:
            return NSNotification.Name.UIApplicationDidEnterBackground
        case .becomeActive:
            return NSNotification.Name.UIApplicationDidBecomeActive
        case .battery:
            return NSNotification.Name.UIDeviceBatteryLevelDidChange
        }
    }
}
