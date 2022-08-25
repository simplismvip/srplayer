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
    public var config: Config
    public var stream: StreamType
    public var scaMode: ScalingMode
    public var playRate: PlaybackRate
    
    public init(video: Video,
                streamType: StreamType,
                config: Config = Config(),
                scaMode: ScalingMode = .aspectFit,
                rate: PlaybackRate = .rate1x0) {
        self.video = video
        self.scaMode = scaMode
        self.stream = streamType
        self.playRate = rate
        self.config = config
    }
    
    public struct Video: Codable {
        // 默认使用的播放器视频地址
        public let videoUrl: URL
        public var title: String?
        public var cover: String?
        public var size: String?
        public var multiURLs: [Video]? // 多码率视频地址
        
        public init(videoUrl: URL, title: String?, cover: String?, size: String?) {
            self.videoUrl = videoUrl
            self.title = title
            self.cover = cover
            self.size = size
        }
    }
    
    public struct Options: Codable {
        
    }
    
    public struct Config: Codable {
        // 默认静音
        public var mute: Bool
        // 默认静音
        public var mirror: Bool
        // 自动播放
        public var autoPlay: Bool
        // 自动跳到上次播放页面
        public var autoSeek: Bool
        
        public init(mute: Bool = false,
                    mirror: Bool = false,
                    autoPlay: Bool = false,
                    autoSeek: Bool = false) {
            self.mute = mute
            self.mirror = mirror
            self.autoPlay = autoPlay
            self.autoSeek = autoSeek
        }
    }
}
