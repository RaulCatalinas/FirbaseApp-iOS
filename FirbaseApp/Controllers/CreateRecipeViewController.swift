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
    UITableViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDataSource
{
    @IBOutlet weak var difficultPickerView: UIPickerView!
    @IBOutlet weak var cuisinesPickerView: UIPickerView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var recipePrepareTimeTextField: UITextField!
    @IBOutlet weak var recipeCookTimeField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mealTypeCollectionView: UICollectionView!
    @IBOutlet weak var recipeServingsStepper: UIStepper!
    @IBOutlet weak var recipeServingsLabel: UILabel!

    private let difficulties: [Difficulty] = [.easy, .medium, .hard]
    private var ingredients: [String] = []
    private var steps: [String] = []
    private var imageData: Data? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure Picker views
        difficultPickerView.delegate = self
        difficultPickerView.dataSource = self

        cuisinesPickerView.delegate = self
        cuisinesPickerView.dataSource = self

        // Configure Table view
        tableView.delegate = self
        tableView.dataSource = self

        // Configure Collection view
        mealTypeCollectionView.delegate = self
        mealTypeCollectionView.dataSource = self
        mealTypeCollectionView.allowsMultipleSelection = true
        mealTypeCollectionView.reloadData()

        // Configure Stepper
        recipeServingsStepper.minimumValue = 1
        recipeServingsStepper.maximumValue = 20

    }

    // MARK: - Picker Views

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {

        if pickerView == difficultPickerView {
            return difficulties.count
        } else {
            return COUSINES.count
        }
    }

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {

        if pickerView == difficultPickerView {
            return difficulties[row].rawValue
        } else {
            return COUSINES[row]
        }
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

        guard
            let selectedIndexPaths = mealTypeCollectionView
                .indexPathsForSelectedItems,
            !selectedIndexPaths.isEmpty
        else {
            self.showAlert(
                title: "No meal type selected",
                message: "Select at least one meal type"
            )
            return
        }

        guard
            let cookTimeText = recipeCookTimeField.text?
                .trimmingCharacters(in: .whitespacesAndNewlines),
            !cookTimeText.isEmpty
        else {
            showAlert(
                title: "Cook time required",
                message: "Please enter the cook time"
            )
            return
        }

        guard let cookTimeInMinutes = Int(cookTimeText),
            cookTimeInMinutes > 0
        else {
            showAlert(
                title: "Invalid cook time",
                message: "Please enter a valid number greater than 0"
            )
            return
        }

        guard
            let prepareTimeText = recipePrepareTimeTextField.text?
                .trimmingCharacters(in: .whitespacesAndNewlines),
            !prepareTimeText.isEmpty
        else {
            showAlert(
                title: "Prepare time required",
                message: "Please enter the prepare time"
            )
            return
        }

        guard let prepareTimeInMinutes = Int(prepareTimeText),
            prepareTimeInMinutes > 0
        else {
            showAlert(
                title: "Invalid prepare time",
                message: "Please enter a valid number greater than 0"
            )
            return
        }

        let selectedMealTypes = selectedIndexPaths.map {
            MEAL_TYPES[$0.row]
        }

        let selectedDifficultIndex = difficultPickerView.selectedRow(
            inComponent: 0
        )
        let selectedDifficult = difficulties[selectedDifficultIndex].rawValue

        let selectedCuisineIndex = cuisinesPickerView.selectedRow(
            inComponent: 0
        )
        let selectedCuisine = COUSINES[selectedCuisineIndex]

        print(
            "Saving recipe: \(recipeName), meal type is \(selectedMealTypes.joined(separator: ", ")), cousine is \(selectedCuisine), and the difficult is \(selectedDifficult)..."
        )
    }

    // MARK: - Collection View
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return MEAL_TYPES.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "meal_type_cell",
                for: indexPath
            ) as! MealTypeCell

        cell.configure(with: MEAL_TYPES[indexPath.row])

        return cell
    }

    // MARK: - Stepper
    @IBAction func servingsStepperChanged(_ sender: UIStepper) {
        recipeServingsLabel.text = "Servings: \(Int(sender.value))"
    }
}
