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
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var repeatPasswordInput: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func singUp(_ sender: Any) {
        AuthManager.signUp(
            firtsName: firstNameInput.text,
            lastName: lastNameInput.text,
            email: userNameInput.text,
            password: passwordInput.text,
            repeatPassword: repeatPasswordInput.text,
            birthday: birthdayDatePicker.date,
            gender:
                genderSegmentedControl.selectedSegmentIndex == 0
                ? .male
                : .female
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
