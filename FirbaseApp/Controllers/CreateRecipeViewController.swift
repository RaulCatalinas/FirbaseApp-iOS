//
//  CreateRecipeViewController.swift
//

import PhotosUI
import UIKit

class CreateRecipeViewController: UIViewController,
    UIPickerViewDelegate,
    UIPickerViewDataSource, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{
    @IBOutlet weak var difficultPickerView: UIPickerView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var recipeIngredientTextField: UITextField!
    @IBOutlet weak var loadImageBtn: UIButton!

    private let difficulties: [Difficulty] = [.easy, .medium, .hard]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure picker views
        difficultPickerView.delegate = self
        difficultPickerView.dataSource = self
    }

    // MARK: - Picker Views

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {

        return difficulties.count
    }

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {

        return difficulties[row].rawValue
    }

    // MARK: - Load Image Button

    @IBAction func loadImageTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()

        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    // MARK: - ImagePicker Delegate

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:
            Any]
    ) {
        guard let image = info[.editedImage] as? UIImage else { return }

        recipeImageView.image = image

        let data = image.jpegData(compressionQuality: 0.8)

        dismiss(animated: true)
    }
}
