//
//  PlayerBulider.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/20.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public struct PlayerBulider {
    public var video: Video
    public var scaMode: ScalingMode
    public var allowsAirPlay = true
    public var shouldAutoplay = true
    public var playbackRate: PlaybackRate
    
    public init(video: Video,
                scaMode: ScalingMode = .aspectFit,
                rate: PlaybackRate = .rate1x0,
                streamType: StreamType = .vod,
                allowsAirPlay: Bool = false,
                shouldAutoplay: Bool = true) {
        self.video = video
        self.scaMode = scaMode
        self.allowsAirPlay = allowsAirPlay
        self.shouldAutoplay = shouldAutoplay
        self.playbackRate = rate
    }
    
    public struct Video: Codable {
        public var url: URL
        public var title: String
        public var cover: String
        public var size: String?
        public var streamType: StreamType
//        init(url: URL, title: String, cover: String, size: CGSize?, streamType: StreamType = .vod) {
//            self.url = url
//            self.title = title
//            self.cover = cover
//            self.size = size
//            self.streamType = streamType
//        }
    }
}
