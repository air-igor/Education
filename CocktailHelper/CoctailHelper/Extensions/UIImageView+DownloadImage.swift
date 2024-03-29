//
//  UIImageView+DownloadImage.swift
//  CoctailHelper
//
//  Created by Игорь Попов on 31.08.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit


extension UIImageView {
func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
            else { return }
        DispatchQueue.main.async() { [weak self] in
            self?.image = image
        }
    }.resume()
}
func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
    guard let url = URL(string: link) else { return }
    downloaded(from: url, contentMode: mode)
}
    
}
