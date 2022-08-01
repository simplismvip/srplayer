//
//  SRLoading.swift
//  SRPlayer
//
//  Created by jh on 2022/8/1.
//

import UIKit

class SRLoading: UIView {
    let contentView: UIView = {
        let view = UIView(frame: CGRect.Rect(0, 0, 40, 40))
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true;
        view.backgroundColor = UIColor.green
        return view
    }()
    
    lazy var leftView: UIView = {
        let view = UIView(frame: CGRect.Rect(0, 0, 20, 20))
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true;
        view.backgroundColor = UIColor.green
        return view
    }()
    
    lazy var centerView: UIView = {
        let view = UIView(frame: CGRect.Rect(0, 0, 20, 20))
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true;
        view.backgroundColor = UIColor.black
        return view
    }()
    
    lazy var rightView: UIView = {
        let view = UIView(frame: CGRect.Rect(0, 0, 20, 20))
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true;
        view.backgroundColor = UIColor.red
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
        contentView.addSubview(leftView)
        contentView.addSubview(centerView)
        contentView.addSubview(rightView)
    }
    
    public func start() {
        
    }
    
    public func stop() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//- (void)updateBallAnimations {
//    if (self.moveDirection == GKBallMoveDirectionPositive) { // 正向
//        CGPoint center = self.greenBall.center;
//        center.x += kBallSpeed;
//        self.greenBall.center = center;
//
//        center = self.redBall.center;
//        center.x -= kBallSpeed;
//        self.redBall.center = center;
//
//        // 缩放动画，绿球放大，红球缩小
//        self.greenBall.transform = [self ballLargerTransformOfCenterX:center.x];
//        self.redBall.transform   = [self ballSmallerTransformOfCenterX:center.x];
//
//        // 更新黑球位置
//        CGRect blackBallFrame = [self.redBall convertRect:self.redBall.bounds toCoordinateSpace:self.greenBall];
//        self.blackBall.frame = blackBallFrame;
//        self.blackBall.layer.cornerRadius = self.blackBall.bounds.size.width * 0.5f;
//
//        // 更新方向 改变三个球的相对位置
//        if (CGRectGetMaxX(self.greenBall.frame) >= self.containerView.bounds.size.width || CGRectGetMinX(self.redBall.frame) <= 0) {
//            // 切换为反向
//            self.moveDirection = GKBallMoveDirectionNegative;
//
//            // 反向运动时，红球在上，绿球在下
//            [self.containerView bringSubviewToFront:self.redBall];
//
//            // 黑球放在红球上面
//            [self.redBall addSubview:self.blackBall];
//
//            // 重置动画
//            [self resetAnimation];
//        }
//    }else if (self.moveDirection == GKBallMoveDirectionNegative) { // 反向
//        // 更新绿球位置
//        CGPoint center = self.greenBall.center;
//        center.x -= kBallSpeed;
//        self.greenBall.center = center;
//
//        // 更新红球位置
//        center = self.redBall.center;
//        center.x += kBallSpeed;
//        self.redBall.center = center;
//
//        // 缩放动画 红球放大 绿球缩小
//        self.redBall.transform = [self ballLargerTransformOfCenterX:center.x];
//        self.greenBall.transform = [self ballSmallerTransformOfCenterX:center.x];
//
//        // 更新黑球位置
//        CGRect blackBallFrame = [self.greenBall convertRect:self.greenBall.bounds toCoordinateSpace:self.redBall];
//        self.blackBall.frame = blackBallFrame;
//        self.blackBall.layer.cornerRadius = self.blackBall.bounds.size.width * 0.5f;
//
//        // 更新方向 改变三个球的相对位置
//        if (CGRectGetMinX(self.greenBall.frame) <= 0 || CGRectGetMaxX(self.redBall.frame) >= self.containerView.bounds.size.width) {
//            // 切换为正向
//            self.moveDirection = GKBallMoveDirectionPositive;
//            // 正向运动 绿球在上 红球在下
//            [self.containerView bringSubviewToFront:self.greenBall];
//            // 黑球放在绿球上面
//            [self.greenBall addSubview:self.blackBall];
//            // 重置动画
//            [self resetAnimation];
//        }
//    }
//}
