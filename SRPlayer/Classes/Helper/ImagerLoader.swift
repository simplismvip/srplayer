//
//  ImagerLoader.swift
//  SRPlayer
//
//  Created by jh on 2022/8/19.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    var caches: NSCache<NSString, ImageLoader> = NSCache()
    
    public func loaderFor(url: String, callback: @escaping (UIImage?) -> Void) {
        let key = url as NSString
        if let loader = caches.object(forKey: key) {
             callback(loader.image)
        } else {
            let loader = ImageLoader(path: url)
            loader.loadImage(callback: callback)
            caches.setObject(loader, forKey: key)
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
