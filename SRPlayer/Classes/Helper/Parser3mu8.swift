//
//  Parser3mu8.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/20.
//

import UIKit

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
                SRLogger.debug($0.description)
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

public class StreamReader {
    let encoding: String.Encoding
    let chunkSize: Int
    var fileHandle: FileHandle!
    let delimData: Data
    var buffer: Data
    var atEof: Bool

    public init?(path: String, delimiter: String = "\n", encoding: String.Encoding = .utf8, chunkSize: Int = 4096) {
        guard let fileHandle = FileHandle(forReadingAtPath: path),
            let delimData = delimiter.data(using: encoding) else {
                return nil
        }
        self.encoding = encoding
        self.chunkSize = chunkSize
        self.fileHandle = fileHandle
        self.delimData = delimData
        self.buffer = Data(capacity: chunkSize)
        self.atEof = false
    }

    public func rewind() {
        fileHandle.seek(toFileOffset: 0)
        buffer.count = 0
        atEof = false
    }

    public func close() {
        fileHandle?.closeFile()
        fileHandle = nil
    }
    
    deinit {
        self.close()
    }
}

extension StreamReader: Sequence {
    public func makeIterator() -> AnyIterator<String> {
        return AnyIterator {
            return self.next()
        }
    }
}

extension StreamReader: IteratorProtocol {
    public func next() -> String? {
        precondition(fileHandle != nil, "Attempt to read from closed file")
        while !atEof {
            if let range = buffer.range(of: delimData) {
                let line = String(data: buffer.subdata(in: 0..<range.lowerBound), encoding: encoding)
                buffer.removeSubrange(0..<range.upperBound)
                return line
            }
            
            let tmpData = fileHandle.readData(ofLength: chunkSize)
            if tmpData.count > 0 {
                buffer.append(tmpData)
            } else {
                atEof = true
                if buffer.count > 0 {
                    let line = String(data: buffer as Data, encoding: encoding)
                    buffer.count = 0
                    return line
                }
            }
        }
        return nil
    }
}
