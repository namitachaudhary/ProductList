//
//  DescriptionTVCell.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 13/03/23.
//

import UIKit
import MGStarRatingView

class DescriptionTVCell: UITableViewCell {

    // IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var ratingView: StarRatingView!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: Public Function
    func setUpCell(productTitle: String, productDescription: String, productRating: Double) {
        titleLabel.text = productTitle
        descriptionLabel.text = productDescription
        ratingView.current = productRating
    }
}
