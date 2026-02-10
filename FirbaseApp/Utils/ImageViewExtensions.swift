//
//  ImageViewExtensions.swift
//  FirbaseApp
//
//  Created by Tardes on 10/2/26.
//

import UIKit

extension UIImageView {
    func loadImage(from url: String) {
        guard let url = URL(string: url) else { return }

        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }

            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
