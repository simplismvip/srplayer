//
//  NetSpeed.swift
//  SRPlayer
//
//  Created by jh on 2022/8/18.
//

import UIKit

public class NetSpeed {
    private var timer: Timer?
    private var netSpeed: CurrNetSpeed?
    private var lastData = ByteData()
    public static let share = NetSpeed()
    
    public var connType: ConnectType {
        if let address = NetTool.getAddress(true) {
            return (address.count > 0) ? .wifi : .wwan
        }
        return .unknow
    }
    
    private func startTimer(_ type: SpeedType, _ timeInterval: TimeInterval) {
        if timer != nil { endNetSpeed() }
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self](_) in
            if let speed = self?.currNetSpeed(type, timeInterval) {
                self?.netSpeed?(speed)
            }
        }
    }
    
    // 停止监听当前网速
    public func endNetSpeed() {
        timer?.invalidate()
        timer = nil
    }
    
    // 打开计时器回调返回当前网速
    public func startNetSpeed(_ type: SpeedType, _ timeInterval: TimeInterval = 1, netSpeed: @escaping CurrNetSpeed) {
        self.netSpeed = netSpeed
        self.startTimer(type, timeInterval)
    }
    
    /// 被动调用获取当前网速
    public func currNetSpeed(_ type: SpeedType, _ timeInterval: TimeInterval = 0.5) -> String {
        if lastData.zero {
            lastData = NetTool.getInterfaceBytes()
            return ""
        } else {
            switch type {
            case .wifi_recv:
                return wifiRecvSpeed(timeInterval)
            case .wifi_sent:
                return wifiSendSpeed(timeInterval)
            case .wwan_recv:
                return wwanRecvSpeed(timeInterval)
            case .wwan_sent:
                return wwanSentSpeed(timeInterval)
            case .all_recv:
                return totalRecvSpeed(timeInterval)
            case .all_sent:
                return totalSentSpeed(timeInterval)
            }
        }
    }
}

// Recv 下载速度
extension NetSpeed {
    /// wifi下载速度
    func wifiRecvSpeed(_ timeInterval: TimeInterval = 0.5) -> String {
        let newByte = NetTool.getInterfaceBytes()
        let recv = (newByte.wifi - lastData.wifi).received.double / timeInterval
        self.lastData = newByte
        return recv.unitString
    }
    
    /// wwan下载速度
    func wwanRecvSpeed(_ timeInterval: TimeInterval = 0.5) -> String {
        let newByte = NetTool.getInterfaceBytes()
        let wwan = (newByte.wwan - lastData.wwan).received.double / timeInterval
        self.lastData = newByte
        return wwan.unitString
    }
    
    ///（wifi+wwan）下载速度
    func totalRecvSpeed(_ timeInterval: TimeInterval = 0.5) -> String {
        let newByte = NetTool.getInterfaceBytes()
        let totalRecv = newByte.totalRecv - lastData.totalRecv
        self.lastData = newByte
        return (totalRecv > 0) ? (totalRecv.double / timeInterval).unitString : "0 KB"
    }
}

// sent 发送速度
extension NetSpeed {
    /// wifi 上传速度
    func wifiSendSpeed(_ timeInterval: TimeInterval = 0.5) -> String {
        let newByte = NetTool.getInterfaceBytes()
        let wifi = (newByte.wifi - lastData.wifi).sent.double / timeInterval
        self.lastData = newByte
        return wifi.unitString
    }
    
    /// wwan 上传速度
    func wwanSentSpeed(_ timeInterval: TimeInterval = 0.5) -> String {
        let newByte = NetTool.getInterfaceBytes()
        let wwan = (newByte.wwan - lastData.wwan).sent.double / timeInterval
        self.lastData = newByte
        return wwan.unitString
    }
    
    ///（wifi+wwan）上传速度
    func totalSentSpeed(_ timeInterval: TimeInterval = 0.5) -> String {
        let newByte = NetTool.getInterfaceBytes()
        let totalSent = newByte.totalSent - lastData.totalSent
        return (totalSent > 0) ? (totalSent.double / timeInterval).unitString : "0 KB"
    }
}

// 暂时不用
extension NetSpeed {
    /// wifi下载速度
    func wifi(_ timeInterval: TimeInterval = 0.5) -> ByteCount {
        let newByte = NetTool.getInterfaceBytes()
        let wifi = newByte.wifi - lastData.wifi
        let byteCount = ByteCount(received: wifi.received, sent: wifi.sent)
        self.lastData = newByte
        return byteCount
    }
    
    func wwan(_ timeInterval: TimeInterval = 0.5) -> ByteCount {
        let newByte = NetTool.getInterfaceBytes()
        let wwan = newByte.wwan - lastData.wwan
        let byteCount = ByteCount(received: wwan.received, sent: wwan.sent)
        self.lastData = newByte
        return byteCount
    }
}
