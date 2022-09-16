//
//  SRDBManager.swift
//  SRPlayer
//
//  Created by jh on 2022/8/24.
//

import UIKit
import ZJMKit

public class SRDBManager {
    private let lock = NSLock()
    public static let share = SRDBManager()
    private var db: SQLiteDB?
    init() {
        if let path = JMTools.jmDocuPath() {
            do {
                try self.db = SQLiteDB.openDB(path + "/video.sqlite")
                try self.db?.create()
            } catch  {
                JMLogger.error("打开数据库失败")
            }
        } else {
            JMLogger.error("数据库地址获取失败")
        }
    }
    
    func insertDB(_ video: PlayerBulider.Video) {
        if queryDB(video) == nil {
            do {
                let sqlVideo = Video(videoUrl: video.videoUrl.lastPathComponent, title: video.title ?? "", cover: video.cover ?? "", duration: 0.0, currTime: 0.0)
                try db?.insert(video: sqlVideo)
            } catch  {
                JMLogger.error("打开数据库失败")
            }
        }
    }
    
    public func queryDB(_ video: PlayerBulider.Video) -> Video? {
        guard let video = db?.query(videoUrl: video.videoUrl.lastPathComponent) else {
            return nil
        }
        return video
    }
    
    public func queryVideo(_ videoName: String) -> Video? {
        guard let video = db?.query(videoUrl: videoName) else {
            return nil
        }
        return video
    }
    
    func updateDB(videoUrl: String, duration: Double, currTime: Double) {
        do {
            let sql = "UPDATE Video SET duration = \(duration), currTime = \(currTime) WHERE videoUrl = '\(videoUrl)';"
            try db?.update(sql: sql)
        } catch  {
            JMLogger.error("打开数据库失败")
        }
    }
    
    func deleteDB(videoUrl: String) {
        do {
            try db?.delete(videoUrl: videoUrl)
        } catch  {
            JMLogger.error("打开数据库失败")
        }
    }
}
