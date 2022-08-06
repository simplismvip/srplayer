//
//  DataParser.swift
//  SRPlayer
//
//  Created by JunMing on 2022/8/5.
//  Copyright © 2022 JunMing. All rights reserved.
//

import UIKit

public struct DataParser<T: Codable> {
    public static func decode(_ name: String, _ ext: String) -> T? {
        if let url = Bundle.bundle.url(forResource: name, withExtension: ext) {
            do {
                let data = try Data(contentsOf: url)
                return parser(data)
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    public static func request(path: String, callback: @escaping (T?) -> Void) {
        guard let url = URL(string: path) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, _) in
            DispatchQueue.main.async {
                if let data = data, (response as? HTTPURLResponse)?.statusCode == 200 {
                    callback(parser(data))
                } else {
                    callback(nil)
                }
            }
        }
        .resume()
    }
    
    public static func parser(_ data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
