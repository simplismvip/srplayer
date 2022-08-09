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
    public var mute: Bool
    public var mirror: Bool
    public var autoPlay: Bool
    public var stream: StreamType
    public var scaMode: ScalingMode
    public var playRate: PlaybackRate
    
    public init(video: Video,
                scaMode: ScalingMode = .aspectFit,
                streamType: StreamType = .vod,
                rate: PlaybackRate = .rate1x0,
                mute: Bool = false,
                mirror: Bool = false,
                autoPlay: Bool = true) {
        self.video = video
        self.scaMode = scaMode
        self.stream = streamType
        self.playRate = rate
        self.mirror = mirror
        self.autoPlay = autoPlay
        self.mute = mute
    }
    
    public struct Video {
        // 默认使用的播放器视频地址
        public let videoUrl: URL
        public var title: String?
        public var cover: String?
        public var resolution: String?
        public var multiURLs: [Video]? // 多码率视频地址
        
        public init(videoUrl: URL, title: String?, cover: String?, resolution: String?) {
            self.videoUrl = videoUrl
            self.title = title
            self.cover = cover
            self.resolution = resolution
        }
    }
}
