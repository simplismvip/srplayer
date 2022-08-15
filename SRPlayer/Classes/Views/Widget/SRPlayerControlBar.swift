//
//  SRPlayerControlBar.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit

public class SRPlayerControlBar: UIView {
    public var view: UIView
    public var items: [SRPlayerItem]
    public var barType: EdgeAreaUnit
    public var screenType: ScreenType
    
    private var boxs = [String: JMWeakBox<UIView>]()
    override init(frame: CGRect) {
        self.items = []
        self.screenType = .half
        self.barType = .top
        self.view = UIView()
        super.init(frame: frame)
        addSubview(view)
        view.snp.makeConstraints { $0.edges.equalTo(self) }
    }
    
    public func setScreenType(_ type: ScreenType) {
        SRLogger.debug("\(type)--\(screenType)")
        if screenType == type { return }
        self.screenType = type
        self.layoutItems()
        self.setupPadding()
    }
    
    private func loadPlayer(_ item: SRPlayerItem) -> UIView? {
        if let itemView = boxs[item.eventName]?.weakObjc {
            return itemView
        } else {
            guard let itemView = item.view else {
                return nil
            }
            boxs[item.eventName] = JMWeakBox<UIView>(itemView)
            if item.direction == .stretchable {
                // 剩余空间两端约束
                itemView.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
                itemView.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
                itemView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
                itemView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
            }
            return itemView
        }
    }
    
    func setupPadding() { }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if let hv = hitView, !super.subviews.contains(hv) && hitView != self {
            return hv
        }
        return nil
    }
    
    deinit {
        SRLogger.error("类\(NSStringFromClass(type(of: self)))已经释放")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Array where Element: SRItem {
    public func style(_ style: ItemStyle) -> Element? {
        return self.filter { $0.itemStyle == style }.first
    }
}

extension SRPlayerControlBar: SRControlBar { 
    public func addItem(_ item: SRPlayerItem) {
        self.items.append(item)
    }
    
    public func sliderItem() -> SRPlayerSliderItem? {
        return items.style(.slider) as? SRPlayerSliderItem
    }
    
    public func buttonItem(_ style: ItemStyle) -> SRPlayerButtonItem? {
        return items.style(style) as? SRPlayerButtonItem
    }
    
    public func titleItem(_ style: ItemStyle) -> SRPlayerTextItem? {
        return items.style(style) as? SRPlayerTextItem
    }
    
    public func findView(_ item: SRPlayerItem?) -> UIView? {
       if let item = item {
           return boxs[item.eventName]?.weakObjc
       }
       return nil
    }
    
    public func layoutItems() {
        self.view.removellSubviews { _ in true }
        self.boxs.removeAll()
        if items.isEmpty { return }
        if let location = items.first?.location {
            let targetItems = items
                .filter({ item in
                    if screenType == .half {
                        return !item.isHalfHidden
                    }
                    return true
                })
            switch location {
            case .top, .bottom:
                horizontalLayout(targetItems)
            case .left, .right:
                verticalLayout(targetItems)
            }
        }
    }
    
    public func layoutItem(_ itemStyle: ItemStyle) {
        if self.barType == barType {
            layoutItems()
        }
    }
    
    public func viewFrom<T: Command>(_ item: T) -> UIView? {
        return nil
    }
}

extension SRPlayerControlBar {
    public func horizontalLayout(_ targetItems: [SRPlayerItem]) {
        // 顺时针( | --> )从最左侧侧布局，记录最右👉侧view的item
        var tempLeftLastItem: SRPlayerItem?
        targetItems
            .filter { $0.direction == .clockwise }
            .forEach { item in
            if let itemView = loadPlayer(item) {
                self.view.addSubview(itemView)
                itemView.snp.makeConstraints { make in
                    make.top.bottom.equalTo(self.view)
                    make.centerY.equalTo(self.view.snp.centerY)
                    
                    if item.size.width == 0 {
                        make.height.equalTo(item.size.height)
                    } else {
                        make.size.equalTo(item.size)
                    }
                    
                    if let v = findView(tempLeftLastItem) {
                        make.left.equalTo(v.snp.right).offset(item.margin.space)
                    } else {
                        make.left.equalTo(self.view.snp.left).offset(item.margin.left)
                    }
                }
                tempLeftLastItem = item
            } else {
                SRLogger.error(item.itemStyle.rawValue)
            }
        }
        
        // 逆时针( <-- ｜ )从最右侧布局，记录最左👈侧view的item
        var tempRightLastItem: SRPlayerItem?
        targetItems
            .reversed()
            .filter { $0.direction == .anticlockwis }
            .forEach { item in
            if let itemView = loadPlayer(item) {
                self.view.addSubview(itemView)
                itemView.snp.makeConstraints { make in
                    make.top.bottom.equalTo(self.view)
                    make.centerY.equalTo(self.view.snp.centerY)
                    
                    if let v = findView(tempRightLastItem) {
                        make.right.equalTo(v.snp.left).offset(-item.margin.space)
                    } else {
                        make.right.equalTo(snp.right).offset(-item.margin.right)
                    }
                    
                    if item.size.width == 0 {
                        make.height.equalTo(item.size.height)
                    } else {
                        make.size.equalTo(item.size)
                    }
                }
                tempRightLastItem = item
            } else {
                SRLogger.error(item.itemStyle.rawValue)
            }
        }
        
        // 剩余空间( | <--> | )布局，使用最左👈侧、最右👉侧view的item
        targetItems
            .filter { $0.direction == .stretchable }
            .forEach { item in
            if let itemView = loadPlayer(item) {
                self.view.addSubview(itemView)
                itemView.snp.makeConstraints { make in
                    make.centerY.equalTo(self.view.snp.centerY)
                    make.top.bottom.equalTo(self.view)
                    if let l = findView(tempLeftLastItem), let r = findView(tempRightLastItem) {
                        make.left.equalTo(l.snp.right).offset(item.margin.space)
                        make.right.equalTo(r.snp.left).offset(-item.margin.space)
                    } else {
                        make.left.equalTo(self.view.snp.right).offset(item.margin.left)
                        make.right.equalTo(self.view.snp.left).offset(-item.margin.right)
                    }
                }
            } else {
                SRLogger.error(item.itemStyle.rawValue)
            }
        }
    }
    
    // 左右两边都是中央开始布局
    func verticalLayout(_ targetItems: [SRPlayerItem]) {
        let offset = ((CGFloat(targetItems.count) / 2) - 0.5) * (targetItems.first?.size.height ?? 1.0)
        var tempItem: SRPlayerItem?
        for item in targetItems {
            if let itemView = loadPlayer(item) {
                self.view.addSubview(itemView)
                itemView.snp.makeConstraints { make in
                    make.left.right.equalTo(self.view)
                    make.size.equalTo(item.size)
                    make.centerX.equalTo(self.view.snp.centerX)
                    if let v = findView(tempItem) {
                        make.bottom.equalTo(v.snp.top)
                    } else {
                        make.centerY.equalTo(self.view.snp.centerY).offset(offset)
                    }
                }
                tempItem = item
            } else {
                SRLogger.error(item.itemStyle.rawValue)
            }
        }
    }
}

