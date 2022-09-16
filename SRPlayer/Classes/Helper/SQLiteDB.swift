//
//  SQLiteManager.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/24.
//  Copyright © 2022 JunMing. All rights reserved.
//

import SQLite3
import ZJMKit

public struct Video {
    public var videoUrl: String
    public var title: String
    public var cover: String
    public var duration: Double
    public var currTime: Double
}

extension String {
    var ns: NSString {
        return self as NSString
    }
}

enum SQLiteError: Error {
    case OpenDatabase(message: String)
    case Prepare(message: String)
    case Step(message: String)
    case Bind(message: String)
}

class SQLiteDB {
    private let db: OpaquePointer?
    fileprivate var errorMsg: String {
        if let errorPointer = sqlite3_errmsg(db) {
            let errorMessage = String(cString: errorPointer)
            return errorMessage
        } else {
            return "No error message provided from sqlite."
        }
    }
    
    init(db: OpaquePointer?) {
        self.db = db
    }
    
    deinit {
        sqlite3_close(db)
    }
    
    private func prepareStatement(sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteError.Prepare(message: errorMsg)
        }
        return statement
    }

    static func openDB(_ path: String) throws -> SQLiteDB? {
        var db: OpaquePointer?
        if sqlite3_open(path, &db) == SQLITE_OK {
            JMLogger.debug("打开数据库成功 \(path)")
            return SQLiteDB(db: db)
        } else {
            defer {
                if db != nil {
                    sqlite3_close(db)
                }
            }
            if let errorPoint = sqlite3_errmsg(db) {
                let message = String(cString: errorPoint)
                throw SQLiteError.OpenDatabase(message: message)
            } else {
                throw SQLiteError.OpenDatabase(message: "No Error Message!")
            }
        }
    }
    
    // 创建数据库表
    func create() throws {
        let createSql = "CREATE TABLE IF NOT EXISTS Video(id INTEGER PRIMARY KEY AUTOINCREMENT, videoUrl CHAR(255), title CHAR(255), cover CHAR(255), duration DOUBLE, currTime DOUBLE);"
        let createStatement = try prepareStatement(sql: createSql)
        defer { sqlite3_finalize(createStatement) }
        guard sqlite3_step(createStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMsg)
        }
        JMLogger.debug("创建数据库表成功.")
    }
}

extension SQLiteDB {
    func insert(video: Video) throws {
        let insertSql = "INSERT INTO Video (id, videoUrl, title, cover, duration, currTime) VALUES (NULL, ?, ?, ?, ?, ?);"
        let insertStatement = try prepareStatement(sql: insertSql)
        defer { sqlite3_finalize(insertStatement) }
        guard   sqlite3_bind_text(insertStatement, 1, video.videoUrl.ns.utf8String, -1, nil) == SQLITE_OK &&
                sqlite3_bind_text(insertStatement, 2, video.title.ns.utf8String, -1, nil) == SQLITE_OK &&
                sqlite3_bind_text(insertStatement, 3, video.cover.ns.utf8String, -1, nil) == SQLITE_OK &&
                sqlite3_bind_double(insertStatement, 4, video.duration) == SQLITE_OK &&
                sqlite3_bind_double(insertStatement, 5, video.currTime) == SQLITE_OK else {
            throw SQLiteError.Bind(message: errorMsg)
        }
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMsg)
        }
    }
    
    func query(videoUrl: String) -> Video? {
        let querySql = "SELECT * FROM Video WHERE videoUrl = ?;"
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            return nil
        }
        defer { sqlite3_finalize(queryStatement) }
        
        // 查询
        guard sqlite3_bind_text(queryStatement, 1, videoUrl.ns.utf8String, -1, nil) == SQLITE_OK else {
            return nil
        }
        
        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
            return nil
        }
        
        guard let sq_VideoUrl = sqlite3_column_text(queryStatement, 1),
              let sq_title = sqlite3_column_text(queryStatement, 2),
              let sq_cover = sqlite3_column_text(queryStatement, 3) else {
            return nil
        }
        
        let videoUrl = String(cString: sq_VideoUrl)
        let title = String(cString: sq_title)
        let cover = String(cString: sq_cover)
        let duration = sqlite3_column_double(queryStatement, 4)
        let currTime = sqlite3_column_double(queryStatement, 5)
        return Video(videoUrl: videoUrl, title: title, cover: cover, duration: duration, currTime: currTime)
    }
    
    // let updateSql = "UPDATE Video SET Name = 'Adam' WHERE Id = 1;"
    func update(sql: String) throws {
        let insertStatement = try prepareStatement(sql: sql)
        defer { sqlite3_finalize(insertStatement) }
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMsg)
        }
    }
    
    func delete(videoUrl: String) throws {
        let delSql = "DELETE FROM Video WHERE urlPath = '\(videoUrl)';"
        let delStatement = try prepareStatement(sql: delSql)
        defer { sqlite3_finalize(delStatement) }

        guard sqlite3_step(delStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMsg)
        }
    }
}
