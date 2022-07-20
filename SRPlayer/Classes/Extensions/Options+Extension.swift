//
//  Options.swift
//  SRPlayer
//
//  Created by jh on 2022/7/20.
//

import UIKit
import IJKMediaFrameworkWithSSL

struct Options {
    static func options() -> IJKFFOptions {
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
}
