//
//  ViewController.swift
//  SRPlayer
//
//  Created by simplismvip on 07/13/2022.
//  Copyright (c) 2022 simplismvip. All rights reserved.
//

import UIKit
import SRPlayer

class ViewController: UIViewController {
    let player = SRPlayerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(player)
        
        player.snp.makeConstraints { make in
            make.left.width.equalTo(view)
            make.height.equalTo(300)
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

