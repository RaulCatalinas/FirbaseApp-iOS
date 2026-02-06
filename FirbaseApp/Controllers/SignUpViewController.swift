//
//  SignUpViewController.swift
//  FirbaseApp
//
//  Created by Tardes on 6/2/26.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func singUp(_ sender: Any) {
        AuthManager.signUp(
            email: userNameInput.text,
            password: passwordInput.text
        ) { [unowned self] result in

            switch result {
            case .success(let user):
                print("Account created successfully!")
                performSegue(withIdentifier: "navigateToHome", sender: nil)

            case .failure(let error):
                print("Error creating account: \(error.localizedDescription)")
            }
        }
    }

}
