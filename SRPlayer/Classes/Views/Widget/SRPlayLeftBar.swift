//
//  SRPlayLeftBar.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//

import UIKit

public class SRPlayLeftBar: SRPlayerControlBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.view.axis = .vertical
        self.view.distribution = .fill
        self.view.alignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
