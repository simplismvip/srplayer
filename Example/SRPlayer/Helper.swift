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

class ImageCache {
    static let shared = ImageCache()
    var caches: NSCache<NSString, ImageLoader> = NSCache()
    
    public func loaderFor(url: String) -> UIImage? {
        let key = url as NSString
        if let loader = caches.object(forKey: key) {
            return loader.image
        } else {
            let loader = ImageLoader(path: url)
            loader.loadImage { _ in }
            caches.setObject(loader, forKey: key)
            return loader.image
        }
    }
    
    class ImageLoader {
        let url: URL?
        var image: UIImage? = nil
        public init(path: String) {
            self.url = URL(string: path)
        }
        
        func loadImage(callback:@escaping (UIImage?) -> Void) {
            guard let poster = url, image == nil else {
                return
            }
            
            URLSession.shared.dataTask(with: poster) { (data, response, _) in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data,
                    let image = UIImage(data: data)
                    else {
                        callback(nil)
                        return
                }
                DispatchQueue.main.async { [unowned self] in
                    self.image = image
                    callback(image)
                }    
            }.resume()
        }
    }
}

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
    func setimage(url: String) {
        image = ImageCache.shared.loaderFor(url: url)
    }
    
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
