//
//  ViewController.swift
//  FirbaseApp
//
//  Created by Tardes on 5/2/26.
//

import FirebaseAuth
import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        if AuthManager.isUserLoggedIn() {
            AppNavigator.showHome()
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
                print("Error sing in: \(error.localizedDescription)")
            }
        }
    }

    @IBAction func singInWithGoogle(_ sender: Any) {
        AuthManager.signIn(with: .google, viewController: self) {
            [unowned self] result in

            switch result {
            case .success:
                print("Signed in successfully!")
                performSegue(withIdentifier: "navigateToHome", sender: nil)

            case .failure(let error):
                print("Error sing in: \(error.localizedDescription)")
            }
        }
    }

    @IBAction func singInWithFacebook(_ sender: Any) {
        AuthManager.signIn(with: .facebook) { [unowned self] result in

            switch result {
            case .success:
                print("Signed in successfully!")
                performSegue(withIdentifier: "navigateToHome", sender: nil)

            case .failure(let error):
                print("Error sing in: \(error.localizedDescription)")
            }
        }
    }

    @IBAction func singInWithApple(_ sender: Any) {
        AuthManager.signIn(with: .apple) { [unowned self] result in

            switch result {
            case .success:
                print("Signed in successfully!")
                performSegue(withIdentifier: "navigateToHome", sender: nil)

            case .failure(let error):
                print("Error sing in: \(error.localizedDescription)")
            }
        }
    }

}
