//
//  SRPlayerTopBar.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//

import UIKit

public class SRPlayerTopBar: SRPlayerControlBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.view.axis = .horizontal
        self.view.distribution = .fill
        self.view.alignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
