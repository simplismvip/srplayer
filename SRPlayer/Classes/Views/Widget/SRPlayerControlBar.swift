//
//  SRPlayerControlBar.swift
//  SRPlayer
//
//  Created by JunMing on 2022/7/13.
//

import UIKit
import ZJMKit

public class SRPlayerControlBar: UIView {
    public var barStyle: ScreenType
    public var items: [SRPlayerItem]
    public var view: UIStackView
    public var barType: ControlBarType
    private var boxs = [String: JMWeakBox<UIView>]()
    
    override init(frame: CGRect) {
        self.barStyle = .half
        self.items = []
        self.barType = .top
        self.view = UIStackView()
        super.init(frame: frame)
        
        self.view.backgroundColor = UIColor.cyan
        self.view.spacing = 5
        
        addSubview(self.view)
        view.snp.makeConstraints { $0.edges.equalTo(self) }
    }
    
    func loadPlayer(_ item: SRPlayerItem) -> UIView? {
        if let itemView = boxs[item.eventName]?.weakObjc {
            return itemView
        } else {
            guard let itemView = createItemView(item) else {
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
    
    func createItemView(_ item: SRPlayerItem) -> UIView? {
        guard let barView = InitClass<UIView>.instance(item.className) else {
            return nil
        }
        barView.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        (barView as? SRItemBarView)?.configure(item)
        return barView
    }
    
    func setupContentPadding() { }

    func setupShadowLayerIfNeed() {}
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitview = super.hitTest(point, with: event)
        if let hv = hitview, super.subviews.contains(hv) {
            return hv
        }
        return nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SRPlayerControlBar: SRControlBar {
    public func addItem(_ item: SRPlayerItem) {
        self.items.append(item)
    }
    
    public func layoutItems() {
        view.removellSubviews { _ in true }
        for item in items {
            if let topView = createItemView(item) {
                self.view.addArrangedSubview(topView)
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
