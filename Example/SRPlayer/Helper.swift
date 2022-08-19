//
//  Helper.swift
//  SRPlayer_Example
//
//  Created by JunMing on 2022/7/17.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit
import SRPlayer
import Kingfisher

struct DataTool<T: Codable> {
    static func decode(_ name: String) -> T? {
        if let url = Bundle.main.url(forResource: name, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let models = try JSONDecoder().decode(T.self, from: data)
                return models
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension UIImageView {
    func setImage(url: String?, placeholder: UIImage? = nil, complate: ((UIImage, URL?) -> Void)? = nil ) {
        if let headerUrl = url {
            self.kf.setImage(with: URL(string: headerUrl), placeholder: placeholder) { (result) in
                switch result {
                case .failure(let error):
                    SRLogger.error("%@", error.errorDescription ?? "")
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
