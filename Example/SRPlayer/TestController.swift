//
//  SRTestController.swift
//  SRPlayer_Example
//
//  Created by JunMing on 2022/8/4.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import SRPlayer

class TestController: UIViewController {
    let warpper = SRWarpper()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        warpper.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupView()
        
        // battery
        warpper.battery.backgroundColor = UIColor.green
        
        // loading
        warpper.start()
        
        // slider
        warpper.setvalue(0.3)
        warpper.minCOlor(UIColor.red)
        warpper.maxColor(UIColor.green)
    }

    
    func setupView() {
        warpper.battery.backgroundColor = UIColor.green
        self.view.addSubview(warpper.battery)
        warpper.battery.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(12)
            make.top.equalTo(view.snp.top).offset(100)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        self.view.addSubview(warpper.loading)
        warpper.loading.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.equalTo(warpper.battery.snp.bottom).offset(80)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        self.view.addSubview(warpper.slider)
        warpper.slider.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(30)
            make.top.equalTo(warpper.loading.snp.bottom).offset(80)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}
