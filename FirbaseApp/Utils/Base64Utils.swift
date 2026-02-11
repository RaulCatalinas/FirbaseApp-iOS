//
//  Base64Utils.swift
//  FirbaseApp
//
//  Created by Tardes on 11/2/26.
//

import UIKit

extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}

extension String {
    var imageFromBase64: UIImage? {
        guard
            let imageData = Data(
                base64Encoded: self,
                options: .ignoreUnknownCharacters
            )
        else {
            return nil
        }
        return UIImage(data: imageData)
    }
}
