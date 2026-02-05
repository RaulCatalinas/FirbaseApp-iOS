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
        Auth.auth().createUser(
            withEmail: userNameInput.text ?? "",
            password: passwordInput.text ?? ""
        ) { [unowned self] authResult, error in
            if let error = error {
                print("Error creating account: \(error)")
                return
            }

            print("Account created successfully!")
            performSegue(withIdentifier: "navigateToHome", sender: nil)
        }
    }

    @IBAction func singIn(_ sender: Any) {
        Auth.auth().signIn(
            withEmail: userNameInput.text ?? "",
            password: passwordInput.text ?? ""
        ) { [unowned self] authResult, error in
            if let error = error {
                print("Error sing in: \(error)")
                return
            }

            print("Signed in successfully!")
            performSegue(withIdentifier: "navigateToHome", sender: nil)
        }
    }

}
