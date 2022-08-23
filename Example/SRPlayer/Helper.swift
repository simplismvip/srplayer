//
//  Helper.swift
//  SRPlayer_Example
//
//  Created by JunMing on 2022/7/17.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import ZJMKit
import SRPlayer
import Kingfisher

extension UIImageView {
    func setImage(url: String?, placeholder: UIImage? = nil, complate: ((UIImage, URL?) -> Void)? = nil ) {
        if let headerUrl = url {
            self.kf.setImage(with: URL(string: headerUrl), placeholder: placeholder) { (result) in
                switch result {
                case .failure(let error):
                    JMLogger.error("%@", error.errorDescription ?? "")
                case .success(let resultImage):
                    complate?(resultImage.image, resultImage.source.url)
                }
            }
        } else {
            self.image = placeholder
        }
    }
}

extension String {
     var image: UIImage? {
        UIImage(named: self)
    }
}
