//
//  SRNetSpeed.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/8.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

//func +(lhs: ByteType, rhs: ByteType) -> ByteType {
//    var result = lhs
//    result.received += rhs.received
//    result.sent += rhs.sent
//    return result
//}

enum NetType {
    case wifi
    case wwan
    case unknow
    var name: String {
        switch self {
        case .wifi:
            return "Wi-Fi"
        case .wwan:
            return "数据流量"
        case .unknow:
            return "无网络"
        }
    }
}

struct NetStatus {
    struct ByteData {
        var wifi: ByteType
        var wwan: ByteType
        
        var total: UInt64 {
            return wifi.total + wwan.total
        }
        
        init() {
            self.wifi = ByteType()
            self.wwan = ByteType()
        }
    }

    struct ByteType {
        var received: UInt64
        var sent: UInt64
        
        var total: UInt64 {
            return received + sent
        }
        
        init() {
            self.received = 0
            self.sent = 0
        }
    }

    static func netStatus() -> NetType {
        if let address = NetStatus.getAddress(false), address.count > 0 {
            return NetType.wifi
        }
        return NetType.wwan
    }
    
    static func getInterfaceBytes() -> ByteData {
        var result = ByteData()
        var addrsPointer: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&addrsPointer) == 0 {
            var pointer = addrsPointer
            while pointer != nil {
                if let addrs = pointer?.pointee {
                    let name = String(cString: addrs.ifa_name)
                    if addrs.ifa_addr.pointee.sa_family == UInt8(AF_LINK) {
                        if name.hasPrefix("en") { // Wifi
                            let networkData = unsafeBitCast(addrs.ifa_data, to: UnsafeMutablePointer<if_data>.self)
                            result.wifi.received += UInt64(networkData.pointee.ifi_ibytes)
                            result.wifi.sent += UInt64(networkData.pointee.ifi_obytes)
                        } else if name.hasPrefix("pdp_ip") { // WWAN
                            let networkData = unsafeBitCast(addrs.ifa_data, to: UnsafeMutablePointer<if_data>.self)
                            result.wwan.received += UInt64(networkData.pointee.ifi_ibytes)
                            result.wwan.sent += UInt64(networkData.pointee.ifi_obytes)
                        }
                    }
                }
                pointer = pointer?.pointee.ifa_next
            }
            freeifaddrs(addrsPointer)
        }
        return result
    }
    
    // 获取Wi-Fi/WWAN ip地址
    static func getAddress(_ isWifi: Bool) -> String? {
        var address : String?
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if name == (isWifi ? "en0" : "pdp_ip0") {
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        return address
    }
}

class StreamCount {
    private var byteData: NetStatus.ByteData
    private var netStatus: NetType
    private var timer: Timer?
    public static var share: StreamCount = {
        return StreamCount()
    }()
    
    init() {
        self.byteData = NetStatus.ByteData()
        self.netStatus = NetType.unknow
    }
    
    public func updateCount() {
        self.netStatus = NetStatus.netStatus()
        let newByte = NetStatus.getInterfaceBytes()
        byteData.wifi.received += newByte.wifi.received
        byteData.wifi.sent += newByte.wifi.sent
        
        byteData.wwan.received += newByte.wwan.received
        byteData.wwan.sent += newByte.wwan.sent
    }
    
    public func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self](_) in
            self?.updateCount()
        }
    }
    
    public func endTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension StreamCount {
    // 当前wifi速度
    func wifiCurrSpeed() -> String {
        let newByte = NetStatus.getInterfaceBytes()
        let wifi = newByte.wifi.total
        return Double(wifi).unitString
    }
    
    // 当前wwan速度
    func wwanCurrSpeed() -> String {
        let newByte = NetStatus.getInterfaceBytes()
        let wwan = newByte.wwan.total
        return Double(wwan).unitString
    }
    
    // 当前速度（wifi+wwan）
    func totalCurrSpeed() -> String {
        let newByte = NetStatus.getInterfaceBytes()
        return String(format: "%@", newByte.total)
    }
}

extension StreamCount {
    // 总wifi消耗流量
    func wifiTotalByte() -> String {
        return String(format: "%@", byteData.wifi.total)
    }
    
    // 总wwan消耗流量
    func wwanTotalByte() -> String {
        return String(format: "%@", byteData.wwan.total)
    }
    
    // 总消耗流量（wifi+wwan）
    func totalAllByte() -> String {
        return String(format: "%@", byteData.total)
    }
}
