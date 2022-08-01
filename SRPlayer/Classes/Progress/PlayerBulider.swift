//
//  PlayerBulider.swift
//  SRPlayer
//
//  Created by jh on 2022/7/20.
//

import UIKit

public struct PlayerBulider {
    public var url: URL
    public var config: Config?
    public var scaMode: ScalingMode = .aspectFit
    public var streamType: StreamType = .vod
    public var allowsAirPlay = true
    public var shouldAutoplay = true
    public var playbackRate: PlaybackRate
    
    public init(url: URL,
                scaMode: ScalingMode = .aspectFit,
                rate: PlaybackRate = .rate1x0,
                streamType: StreamType = .vod,
                allowsAirPlay: Bool = false,
                shouldAutoplay: Bool = true) {
        self.url = url
        self.scaMode = scaMode
        self.streamType = streamType
        self.allowsAirPlay = allowsAirPlay
        self.shouldAutoplay = shouldAutoplay
        self.playbackRate = rate
    }
    
    public struct Config {
        var title: String?
        var size: CGSize?
    }
}
