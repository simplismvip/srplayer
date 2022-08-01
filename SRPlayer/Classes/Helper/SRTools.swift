//
//  Tools.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/14.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

struct Tools {
    func a() {
        let b = InitClass<UIView>.instance("SRPlayerBottomBar")
    }
    
    
}

//let bottom = InitClass<SRPlayerBottomBar>.instance("SRPlayerBottomBar")
//SRLogger.debug(bottom)
public struct InitClass<T: NSObject> {
    public static func instance(_ className: String) -> T? {
        guard let clazz = classFrom(className) as? T.Type else {
            return nil
        }
        return clazz.init()
    }
    
    static func classFrom(_ className: String) -> AnyClass? {
        guard let appName = Bundle.bundle.object(forInfoDictionaryKey: "CFBundleName") as? String else {
            return nil
        }
        
        guard let newClass = NSClassFromString(appName + "." + className) else {
            return nil
        }
        
        return newClass
    }
}

extension Bundle {
    /// 当前项目bundle
    static var bundle: Bundle {
        return Bundle(for: SRPlayerController.self)
    }
    
    /// 获取bundle中文件路径
    static func path(resource: String, ofType: String) -> String? {
        return Bundle.bundle.path(forResource: resource, ofType: ofType)
    }
    
    /// Resours文件bundle
    static var resouseBundle: Bundle? {
        if let budl = Bundle.path(resource: "SRPlayer", ofType: "bundle") {
            return Bundle(path: budl)
        } else {
            return nil
        }
    }

    // 类方法
    class func localizedString(forKey key: String) -> String? {
        return self.localizedString(forKey: key, value: nil)
    }

    // 参数value为可选值，可以传值为nil。
    class func localizedString(forKey key: String, value: String?) -> String? {
        var language = Locale.preferredLanguages.first
        // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
        if language?.hasPrefix("en") ?? false {
            language = "en"
        } else if language?.hasPrefix("zh") ?? false {
            language = "zh-Hans"
        } else {
            language = "en"
        }

        if let path = Bundle.path(resource: language!, ofType: "lproj") {
            let v = Bundle(path: path)?.localizedString(forKey: key, value: value, table: nil)
            return Bundle.main.localizedString(forKey: key, value: v, table: nil)
        } else {
            return nil
        }
    }
}

extension Int {
    var format: String {
        return jmCurrentTime
            .replacingOccurrences(of: "时", with: ":")
            .replacingOccurrences(of: "分", with: ":")
            .replacingOccurrences(of: "秒", with: "")
    }
}
