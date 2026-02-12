//
//  MealTypeCell.swift
//  FirbaseApp
//
//  Created by Tardes on 11/2/26.
//

import UIKit

class MealTypeCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        contentView.backgroundColor = .systemBackground
    }

    override var isSelected: Bool {
        didSet {
            contentView.layer.borderColor =
                isSelected
                ? UIColor.systemBlue.cgColor
                : UIColor.systemGray4.cgColor

            titleLabel.textColor = isSelected ? .systemBlue : .label
        }
    }

    func configure(with mealType: String) {
        titleLabel.text = mealType
    }
}
