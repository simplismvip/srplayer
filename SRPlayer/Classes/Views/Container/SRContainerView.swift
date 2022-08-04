//
//  SRContainerView.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import SnapKit

public class SRContainerView: UIView, SRContent {
    public let playerView: SRPlayerView
    public let bkgView: SRBkgView
    public let barrageView: SRBarrageView
    public let floatView: SRFloatView
    public let edgeAreaView: SREdgeAreaView
    public let moreAreaView: SRMoreAreaView
    public let maskAreaView: SRMaskView
    public override init(frame: CGRect) {
        self.playerView = SRPlayerView()
        self.bkgView = SRBkgView()
        self.barrageView = SRBarrageView()
        self.edgeAreaView = SREdgeAreaView()
        self.floatView = SRFloatView()
        self.moreAreaView = SRMoreAreaView()
        self.maskAreaView = SRMaskView()
        super.init(frame: frame)
        playerView.canPierce = false
        addSubview(playerView)
        playerView.snp.makeConstraints { make in
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
        
//        addSubview(barrageView)
//        barrageView.snp.makeConstraints { make in
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
    
    deinit {
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
}
