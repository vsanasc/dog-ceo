//
//  UIImageView+Cache.swift
//  Dog CEO
//
//  Created by Vitor on 03-04-21.
//

import UIKit

extension UIImageView {

    func loadImage(fromURL url: String, placeholder: UIImage? = nil) {
        guard let imageURL = URL(string: url) else {
            return
        }
        let cache = URLCache.shared
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .utility).async {
            if let data = cache.cachedResponse(for: request)?.data,
               let imageFromData = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = imageFromData
                }
            } else {
                DispatchQueue.main.async {
                    self.image = placeholder
                }
                URLSession.shared.dataTask(
                    with: request,
                    completionHandler: { data, response, error in
                        if let data = data,
                           let response = response as? HTTPURLResponse,
                           response.statusCode == 200,
                           let image = UIImage(data: data) {

                            let cachedData = CachedURLResponse(response: response, data: data)
                            cache.storeCachedResponse(cachedData, for: request)
                            DispatchQueue.main.async {
                                self.image = image
                            }
                        }

                    }
                ).resume()
            }
        }
    }
}
