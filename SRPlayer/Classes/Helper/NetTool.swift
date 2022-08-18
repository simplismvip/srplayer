//
//  SRNetSpeed.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/8.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

struct ByteData {
    var wifi: ByteCount = ByteCount()
    var wwan: ByteCount = ByteCount()
    
    var totalRecv: UInt64 {
        return wifi.received + wwan.received
    }
    
    var totalSent: UInt64 {
        return wifi.sent + wwan.sent
    }
    
    var total: UInt64 {
        return wifi.total + wwan.total
    }
    
    var zero: Bool {
        return wifi.zero && wwan.zero
    }
}

struct ByteCount {
    var received: UInt64 = 0
    var sent: UInt64 = 0
    
    var total: UInt64 {
        return received + sent
    }

    var zero: Bool {
        return (received == 0) && (sent == 0)
    }
}

struct NetTool {
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
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                let name = String(cString: interface.ifa_name)
                if name == (isWifi ? "en0" : "pdp_ip0") {
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
