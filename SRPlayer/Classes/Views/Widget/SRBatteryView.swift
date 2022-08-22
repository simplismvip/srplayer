//
//  SRBatteryView.swift
//  SRPlayer
//
//  Created by jh on 2022/8/4.
//

import UIKit

class SRBatteryView: UIView {
    private var is12Hour = false
    private let wifi: UILabel
    private let timeL: UILabel
    private let battery: Bettary
    private var timer: Timer?
    
    override init(frame: CGRect) {
        self.wifi = UILabel(frame: .zero)
        self.battery = Bettary(frame: .zero)
        self.timeL = UILabel(frame: .zero)
        super.init(frame: frame)
        setupViews()
        
        updateTime()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self](_) in
            self?.updateTime()
        }
    }
    
    private func setupViews() {
        addSubview(wifi)
        addSubview(timeL)
        addSubview(battery)
        
        wifi.jmConfigLabel(alig: .center, font: UIFont.jmBold(10), color: UIColor.white)
        wifi.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.top.height.equalTo(self)
            make.centerY.equalTo(snp.centerY)
        }
        
        timeL.jmConfigLabel(alig: .center, font: UIFont.jmBold(11), color: UIColor.white)
        timeL.snp.makeConstraints { (make) in
            make.top.height.equalTo(self)
            make.centerX.equalTo(snp.centerX)
        }
        
        battery.snp.makeConstraints { (make) in
            make.right.equalTo(snp.right).offset(-5)
            make.top.height.equalTo(self)
            make.width.equalTo(26)
        }
    }
    
    private func updateTime() {
        let dateFormat = DateFormatter()
        if is12HourFormat() {
            dateFormat.amSymbol = "上午"
            dateFormat.pmSymbol = "下午"
            dateFormat.dateFormat = "aaah:mm"
        } else {
            dateFormat.dateFormat = "H:mm"
        }
        dateFormat.calendar = Calendar(identifier: .gregorian)
        timeL.text = dateFormat.string(from: Date())
        wifi.text = NetSpeed.share.connType.name
    }
    
    // 判断是否是24小时制
    private func is12HourFormat() -> Bool {
        if let formatStr = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current) {
            let containsA = (formatStr as NSString).range(of: "a")
            return containsA.location != NSNotFound
        }
        return false
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Bettary: UIView {
    let battery = CAShapeLayer()
    let layerRight = CAShapeLayer()
    let text = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(layerRight)
        layer.addSublayer(battery)
        addSubview(text)
        text.jmConfigLabel(alig: .center, font: UIFont.jmBold(8), color: UIColor.white)
        updateValue()
        
        NotificationCenter.default.jm.addObserver(target: self, name: Noti.battery.strName) { [weak self](_) in
            self?.updateValue()
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let x = (jmWidth - 20.0)/2.0
        let y = (jmHeight - 10.0)/2.0
        battery.lineWidth = 0.5;
        battery.strokeColor = UIColor.white.cgColor
        battery.fillColor = UIColor.clear.cgColor;
        battery.path = UIBezierPath(roundedRect: CGRect.Rect(x, y, 20, 10), cornerRadius: 2).cgPath
        
        let right = UIBezierPath()
        right.move(to: CGPoint(x: x + 20, y: 5 + y))
        right.addLine(to: CGPoint(x: x + 22, y: 5 + y))
        layerRight.lineWidth = 2;
        layerRight.strokeColor = UIColor.white.cgColor
        layerRight.fillColor = UIColor.clear.cgColor;
        layerRight.path = right.cgPath
        text.frame = CGRect.Rect(0, 0, 20, 8)
        text.center = CGPoint(x: jmWidth/2, y: jmHeight/2)
    }
    
    func updateValue() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        var level = UIDevice.current.batteryLevel
        if level < 0 { level = 1.0 }
        text.text = String(format: "%.0f", level * 100)
    }
    
    deinit {
        NotificationCenter.default.jm.removeObserver(target: self, Noti.battery.strName)
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
