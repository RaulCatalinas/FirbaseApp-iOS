//
//  ViewController.swift
//  FirbaseApp
//
//  Created by Tardes on 5/2/26.
//

import FirebaseAuth
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func singUp(_ sender: Any) {
        AuthManager.singUp(
            email: userNameInput.text,
            password: passwordInput.text
        ) { [unowned self] result in

            switch result {
            case .success(let user):
                print("Account created successfully!")
                performSegue(withIdentifier: "navigateToHome", sender: nil)

            case .failure(let error):
                print("Error creating account: \(error)")
            }
        }
    }

    @IBAction func singIn(_ sender: Any) {
        AuthManager.signIn(
            email: userNameInput.text,
            password: passwordInput.text
        ) { [unowned self] result in

            switch result {
            case .success:
                print("Signed in successfully!")
                performSegue(withIdentifier: "navigateToHome", sender: nil)

            case .failure(let error):
                print("Error sing in: \(error)")
            }
        }
    }

}
