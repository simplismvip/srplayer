//
//  SRContainerView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import SnapKit

public class SRContainerView: UIView, SRBaseContainer {
    public var player: SRPlayerView
    public var bkgView: SRBkgView
    public var barrageView: SRBarrageView
    public var floatView: SRFloatView
    public var edgeAreaView: SREdgeAreaView
    public var moreAreaView: SRMoreAreaView
    public var maskAreaView: SRMaskView
    
    public override init(frame: CGRect) {
        self.player = SRPlayerView()
        self.bkgView = SRBkgView()
        self.barrageView = SRBarrageView()
        self.edgeAreaView = SREdgeAreaView()
        self.floatView = SRFloatView()
        self.moreAreaView = SRMoreAreaView()
        self.maskAreaView = SRMaskView()
        super.init(frame: frame)
        
        addSubview(player)
        player.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        addSubview(bkgView)
        bkgView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        addSubview(floatView)
        floatView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        addSubview(edgeAreaView)
        edgeAreaView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
//        subviewsRandColor()
        
//        addSubview(floatView)
//        floatView.snp.makeConstraints { make in
//            make.edges.equalTo(self)
//        }
        
//        addSubview(moreAreaView)
//        moreAreaView.snp.makeConstraints { make in
//            make.edges.equalTo(self)
//        }
        
//        addSubview(maskAreaView)
//        maskAreaView.snp.makeConstraints { make in
//            make.edges.equalTo(self)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
