//
//  SRNetSpeed.swift
//  SRPlayer
//
//  Created by jh on 2022/8/8.
//

import UIKit

struct SRNetSpeed {
    /*获取网络流量信息*/
    public static func getInterfaceBytes() -> Float {
//        struct ifaddrs *ifa_list = 0, *ifa;
//        var ifaddrs : UnsafeMutablePointer<ifaddrs>?
//        guard getifaddrs(&ifaddrs) == 0 else { return 0.0 }
//        guard let firstAddr = ifaddrs else { return 0.0 }
//
//        var iBytes: uint = 0
//        var oBytes: uint = 0
//        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
//            let interface = ifptr.pointee
//            // Check for IPv4 or IPv6 interface:
//            let addrFamily = interface.ifa_addr.pointee.sa_family
//            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
//
//                var ifaddrs : UnsafeMutablePointer<ifaddrs>?
//
//                let name = String(cString: interface.ifa_name)
//                if  name == (isWifi ? "en0" : "pdp_ip0") {
//                    // Convert interface address to a human readable string:
//                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
//                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
//                                &hostname, socklen_t(hostname.count),
//                                nil, socklen_t(0), NI_NUMERICHOST)
//
//                }
//            }
//        }
//        freeifaddrs(ifaddrs)
//        return 0.0
//
//        for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
//        {
//            if (AF_LINK != ifa->ifa_addr->sa_family)
//               continue;
//            if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
//                continue;
//            if (ifa->ifa_data == 0)
//                continue;
//      /* Not a loopback device. */
//           if (strncmp(ifa->ifa_name, "lo", 2))
//            {
//                struct if_data *if_data = (struct if_data *)ifa->ifa_data;
//                iBytes += if_data->ifi_ibytes;
//                oBytes += if_data->ifi_obytes;
//            }
//        }
//        freeifaddrs(ifa_list);
//        NSLog(@"\n[getInterfaceBytes-Total]%d,%d",iBytes,oBytes);
//        return iBytes + oBytes;
        return 0.0
    }
    
    public static func getAddress(_ isWifi: Bool) -> String? {
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
                if  name == (isWifi ? "en0" : "pdp_ip0") {
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

//#import "ViewController.h"
//#include <ifaddrs.h>
//#include <arpa/inet.h>
//#include <net/if.h>
//@interface ViewController ()
//@end
//@implementation ViewController
//- (void)viewDidLoad {
//    [super viewDidLoad]；
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getInternetface) userInfo:nil repeats:YES]；
//    [timer fireDate];
//}
//- (void)getInternetface {
//    long long hehe = [self getInterfaceBytes];
//    NSLog(@"hehe:%lld",hehe)；
//}
///*获取网络流量信息*/
//- (long long) getInterfaceBytes
//{
//    struct ifaddrs *ifa_list = 0, *ifa;
//    if (getifaddrs(&ifa_list) == -1)
//    {
//        return 0;
//    }
//    uint32_t iBytes = 0;
//    uint32_t oBytes = 0;
//    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
//    {
//        if (AF_LINK != ifa->ifa_addr->sa_family)
//           continue;
//        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
//            continue;
//        if (ifa->ifa_data == 0)
//            continue;
//  /* Not a loopback device. */
//       if (strncmp(ifa->ifa_name, "lo", 2))
//        {
//            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
//            iBytes += if_data->ifi_ibytes;
//            oBytes += if_data->ifi_obytes;
//        }
//    }
//    freeifaddrs(ifa_list);
//    NSLog(@"\n[getInterfaceBytes-Total]%d,%d",iBytes,oBytes);
//    return iBytes + oBytes;
//}
//@end
