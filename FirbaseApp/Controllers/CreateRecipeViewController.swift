//
//  CreateRecipeViewController.swift
//

import PhotosUI
import UIKit

class CreateRecipeViewController: UIViewController,
    UIPickerViewDelegate,
    UIPickerViewDataSource,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITableViewDelegate,
    UITableViewDataSource
{
    @IBOutlet weak var difficultPickerView: UIPickerView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    private let difficulties: [Difficulty] = [.easy, .medium, .hard]
    private var ingredients: [String] = []
    private var steps: [String] = []
    private var imageData: Data? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure picker views
        difficultPickerView.delegate = self
        difficultPickerView.dataSource = self

        // Configure Table view
        tableView.delegate = self
        tableView.dataSource = self
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

        imageData = image.jpegData(compressionQuality: 0.8)

        dismiss(animated: true)
    }

    // MARK: - Table view

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        if section == 0 {
            return ingredients.count
        } else {
            return steps.count
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )

        if indexPath.section == 0 {
            cell.textLabel?.text = "• \(ingredients[indexPath.row])"
        } else {
            cell.textLabel?.text =
                "\(indexPath.row + 1). \(steps[indexPath.row])"
        }

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return section == 0 ? "Ingredients" : "Steps"
    }

    @IBAction func addElementTapped(_ sender: UIButton) {
        let isbtnAddIngredient = sender.titleLabel?.text == "Add ingredient"

        self.showAlert(
            title: isbtnAddIngredient ? "Add ingredient" : "Add Step",
            placeholder:
                isbtnAddIngredient
                ? "e.g., 2 tomatoes"
                : "e.g., Chop the onions"
        ) { [self] text in

            guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }

            isbtnAddIngredient ? ingredients.append(text) : steps.append(text)
            tableView.reloadData()
        }
    }

    @IBAction func saveRecipeTapped(_ sender: Any) {

        guard let recipeName = recipeNameTextField.text,
            !recipeName.isEmpty
        else {
            self.showAlert(
                title: "No recipe name",
                message: "Recipe name required"
            )

            return
        }

        guard ingredients.count > 0 else {
            self.showAlert(
                title: "No ingredients added",
                message: "Add at least one ingredient"
            )

            return
        }

        guard steps.count > 0 else {
            self.showAlert(
                title: "No steps added",
                message: "Add at least one step"
            )

            return
        }

        print("Saving recipe: \(recipeName)...")
    }
}
