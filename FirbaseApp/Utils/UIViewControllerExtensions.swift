//
//  Dialogs.swift
//  FirbaseApp
//
//  Created by Tardes on 11/2/26.
//

import UIKit

extension UIViewController {
    func showAlert(
        title: String,
        placeholder: String,
        completion: @escaping (String) -> Void
    ) {

        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )

        alert.addTextField { textField in
            textField.placeholder = placeholder
        }

        let save = UIAlertAction(title: "Save", style: .default) { _ in
            if let text = alert.textFields?.first?.text,
                !text.isEmpty
            {
                completion(text)
            }
        }

        alert.addAction(save)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(alert, animated: true)
    }
}
