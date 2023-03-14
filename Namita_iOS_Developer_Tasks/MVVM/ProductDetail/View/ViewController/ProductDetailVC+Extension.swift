//
//  ProductDetailVC+Extension.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 13/03/23.
//

import Foundation
import UIKit

// MARK: Public functions
extension ProductDetailsVC {
    func initialSetup() {
        prodictDetailViewModel.getProductDetails(productId: self.productId)
        productDetailTableView.reloadData()
    }
}

// MARK: Private functions
extension ProductDetailsVC {
    private func uiSetUp() {
        setImageForProduct(imageUrl: productDetailsResponse?.image, imageView: productImageView)
        priceLabel.text = "₹ \(productDetailsResponse?.price ?? CharacterConstants.emptyDoubleValue)"
    }
    
    // MARK: Private Functions
    fileprivate func setImageForProduct(imageUrl: String?, imageView: UIImageView) {
            guard let productURL = imageUrl else {
                return
            }
            
            if let thumbnailUrl = URL(string: productURL) {
                imageManager.getImageFrom(url: thumbnailUrl) { image, urlString in
                    self.imageManager.saveImageInCache(image: image, forkey: productURL)
                    DispatchQueue.main.async {
                        if productURL == urlString {
                            imageView.image = image
                        }
                    }
                }
            }
        }
}

// MARK: IBActions
extension ProductDetailsVC {
    @IBAction func deleteProductButtonAction(_ sender: UIButton) {
        delegate?.performActionWith(actionType: ProductActionType.deleteProduct, productId: productDetailsResponse?.id ?? CharacterConstants.emptyIntValue)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateProductButtonAction(_ sender: UIButton) {
        delegate?.performActionWith(actionType: ProductActionType.updateProduct, productId: productDetailsResponse?.id ?? CharacterConstants.emptyIntValue)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: UITableView Delegate and DataSource functions
extension ProductDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.descriptionTVCell.value, for: indexPath) as? DescriptionTVCell else{
            return UITableViewCell()
        }
        cell.setUpCell(productTitle: productDetailsResponse?.title ?? CharacterConstants.emptyString, productDescription: productDetailsResponse?.description ?? CharacterConstants.emptyString, productRating: productDetailsResponse?.rating?.rate ?? CharacterConstants.emptyDoubleValue)
        return cell
    }
}

// MARK: WebService functions
extension ProductDetailsVC: ProductDetailsViewModelDelgate{
    func didReceiveProductDetails(response: ProductDetailsResponse?) {
        productDetailsResponse = response
        productDetailTableView.reloadData()
        uiSetUp()
    }
    
    
}
