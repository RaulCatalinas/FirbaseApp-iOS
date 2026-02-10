//
//  RecipeCell.swift
//  FirbaseApp
//
//  Created by Tardes on 10/2/26.
//

import UIKit

class RecipeCell: UITableViewCell {
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeMealTypeLabel: UILabel!
    @IBOutlet weak var recipeTagsLabel: UILabel!
    @IBOutlet weak var recipeDifficultLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with recipe: Recipe) {
        recipeTitleLabel.text = recipe.name
        //recipeTitleLabel.sizeToFit()
        recipeMealTypeLabel.text = recipe.mealType.joined(separator: ", ")
        recipeDifficultLabel.text = recipe.difficulty.rawValue
        recipeImageView.loadImage(from: recipe.image)
        recipeTagsLabel.text = recipe.tags.joined(separator: ", ")
    }

}
