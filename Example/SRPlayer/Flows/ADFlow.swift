//
//  ADFlow.swift
//  SRPlayer_Example
//
//  Created by jh on 2022/8/15.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import SRPlayer

class ADFlow: NSObject {
    var model: ADModel
    override init() {
        self.model = ADModel()
    }
}

extension ADFlow: SRFlow {
    func configFlow() {
        
    }
    
    func willRemoveFlow() {
        
    }
    
    func didRemoveFlow(){
        
    }
}
