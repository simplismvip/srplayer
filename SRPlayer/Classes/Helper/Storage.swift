//
//  Storage.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/8.
//  Copyright © 2022 JunMing. All rights reserved.
//

import Foundation

@propertyWrapper
struct Storage<T: Codable> {
    var key: String
    var defaultT: T
    private let defaults = UserDefaults.standard
    var wrappedValue: T {
        get {
            guard let jsonString = defaults.string(forKey: key) else { return defaultT }
            guard let jsonData  = jsonString.data(using: .utf8) else { return defaultT }
            guard let value = try? JSONDecoder().decode(T.self, from: jsonData)  else { return defaultT }
            return value
        }
        set {
            guard let jsonData = try? JSONEncoder().encode(newValue) else {return}
            let jsonString = String(bytes: jsonData, encoding: .utf8)
            defaults.setValue(jsonString, forKey: key)
        }
    }
  
    init(key: String, `default`: T) {
        self.key = key
        self.defaultT = `default`
    }
}

public class JMBookStore {
    private var queue = DispatchQueue(label: "com.search.cacheQueue")
    public static let share: JMBookStore = {
        return JMBookStore()
    }()
    
    /// 归档模型
    public static func encodeObject<T: Encodable>(_ object: T, cachePath: String) {
        JMBookStore.share.queue.async {
            do {
                let data = try PropertyListEncoder().encode(object)
                NSKeyedArchiver.archiveRootObject(data, toFile: cachePath)
            }catch let error {
                SRLogger.debug("data cache \(error.localizedDescription)!!!⚽️⚽️⚽️")
            }
        }
    }
    
    /// 解档模型
    public static func decodeObject<T: Codable>(cachePath: String, complate: @escaping (T?)->()) {
        JMBookStore.share.queue.async {
            guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: cachePath) as? Data else {
                DispatchQueue.main.async { complate(nil) }
                return
            }
            
            do {
                let object = try PropertyListDecoder().decode(T.self, from: data)
                DispatchQueue.main.async { complate(object) }
            }catch let error {
                SRLogger.debug("data cache \(error.localizedDescription)!!!⚽️⚽️⚽️")
            }
        }
    }
    
    /// 解档模型
    public static func decodeMain<T: Codable>(cachePath: String, complate: @escaping (T?)->()) {
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: cachePath) as? Data else {
            DispatchQueue.main.async { complate(nil) }
            return
        }
        
        do {
            let object = try PropertyListDecoder().decode(T.self, from: data)
            DispatchQueue.main.async { complate(object) }
        }catch let error {
            SRLogger.debug("data cache \(error.localizedDescription)!!!⚽️⚽️⚽️")
        }
    }
    
    /// 删除归档文件
    public static func deleteDecode(_ cachePath: String) {
        let manager = FileManager.default
        if manager.fileExists(atPath: cachePath) && manager.isDeletableFile(atPath: cachePath) {
            try? manager.removeItem(atPath: cachePath)
        }
    }
}
