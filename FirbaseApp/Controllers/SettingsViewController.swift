//
//  SettingsViewController.swift
//  FirbaseApp
//
//  Created by Tardes on 6/2/26.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signOut(_ sender: Any) {
        defer {
            AppNavigator.showAuth()
        }

        AuthManager.signOut {
            result in

            if case .failure(let error) = result {
                print("Error signing out: \(error.localizedDescription)")
            } else {
                print("Successfully signed out!")
            }
        }
    }

}
