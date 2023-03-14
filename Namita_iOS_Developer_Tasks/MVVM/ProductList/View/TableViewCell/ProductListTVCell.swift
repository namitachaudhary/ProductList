//
//  ProductListTVCell.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 13/03/23.
//

import UIKit

class ProductListTVCell: UITableViewCell {
    // IBOutlest
    @IBOutlet private weak var attributeView: UIView!
    @IBOutlet private weak var productNameLbl: UILabel!
    @IBOutlet private weak var productPriceLbl: UILabel!
    @IBOutlet private weak var productImageV: UIImageView!
    
    // MAR: Private Variables
    private var imageManager = ImageManager()
    
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
    func setUpCell(productData: ProductListResponse) {
        
        attributeView.roundCorners(corners: .allCorners, radius: 5.0)
        attributeView.addShadow()
        
        self.productPriceLbl.text = "₹ \(productData.price ?? CharacterConstants.emptyDoubleValue)" // Assuming the price is in Indian rupees
        self.productNameLbl.text = productData.title ?? CharacterConstants.emptyString
        setImageForCharacter(imageUrl: productData.image, imageView: productImageV)
    }
    
    // MARK: Private Functions
    fileprivate func setImageForCharacter(imageUrl: String?, imageView: UIImageView) {
        guard let characterURL = imageUrl else {
            return
        }
        
        if let thumbnailUrl = URL(string: characterURL) {
            imageManager.getImageFrom(url: thumbnailUrl) { image, urlString in
                self.imageManager.saveImageInCache(image: image, forkey: characterURL)
                DispatchQueue.main.async {
                    if characterURL == urlString {
                        imageView.image = image
                    }
                }
            }
        }
    }

}
