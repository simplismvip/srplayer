//
//  Parser3mu8.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/20.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

public struct v3mu8: Codable, CustomStringConvertible {
    public var channel: String?
    public var url: String?
    
    public var description: String {
        return String("Channel:\(channel), Url:\(url)")
    }
}

public struct Parser3mu8 {
    public static func readLines(_ path: String) {
        guard let lines = StreamReader(path: path, delimiter: "\n") else {
            return
        }
        
        var channel: String?
        lines.makeIterator()
            .map { line -> v3mu8? in
                if line.starts(with: "#EXTINF") {
                    channel = replace(line)
                } else if line.starts(with: "http") {
                    return v3mu8(channel: channel, url: replace(line))
                }
                return nil
            }
            .compactMap { $0 }
            .forEach {
                JMLogger.debug($0.description)
            }
    }
    
    static func replace(_ target: String?) -> String? {
        guard let v = target?.split(separator: ",").last else {
            return target
        }
        return String(v)
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ":", with: ".")
            .replacingOccurrences(of: "\\", with: ".")
            .replacingOccurrences(of: "|", with: ".")
            .replacingOccurrences(of: "?", with: ".")
            .replacingOccurrences(of: "*", with: ".")
            .replacingOccurrences(of: ">", with: ".")
            .replacingOccurrences(of: "<", with: ".")
    }
}

public struct SRToast {
    static func toast(_ text: String, second: Int = 1) {
        JMTextToast.share.jmShowString(text: text, seconds: TimeInterval(second))
    }
}
