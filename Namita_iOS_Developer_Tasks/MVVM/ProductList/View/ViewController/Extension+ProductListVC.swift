//
//  Extension+.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 13/03/23.
//

import UIKit

//MARK: Public Functions
extension ProductListVC {
    func initialSetUp() {
        productListVM.getCompanyList()
        productTV.delegate = self
        productTV.dataSource = self
        productTV.estimatedRowHeight = ProductListConstants.tableViewRowHeight
        productTV.rowHeight = UITableView.automaticDimension
    }
}

// MARK: IBActions
extension ProductListVC {
    @IBAction func addProductButtonAction(_ sender: UIButton) {
        addProductViewModel.addProduct(addProductRequest: commonRequest)
    }
}

//MARK: UITableview Delegate and Datasource
extension ProductListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListResponse?.count ?? CharacterConstants.emptyIntValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.productListTVCell.value, for: indexPath) as? ProductListTVCell else{
            return UITableViewCell()
        }
        cell.setUpCell(productData: (productListResponse?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewControllerAccessors.productDetailsVc
        vc.productId = productListResponse?[indexPath.row].id ?? CharacterConstants.emptyIntValue
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: Action Delegate
extension ProductListVC: ActionItemDelegate {
    func performActionWith(actionType: String, productId: Int) {
        if actionType == ProductActionType.deleteProduct {
            deleteProductViewModel.deleteProductWith(productId: productId)
        } else {
            updateProductViewModel.updateProduct(productId: productId, updateProductRequest: commonRequest)
        }
    }
}

// MARK: Web Service methods
extension ProductListVC: ProductListViewModelDelgate, DeleteProductViewModelDelgate, UpdateProductViewModelDelgate, AddProductViewModelDelgate {
    func didReceiveAddProductResponse(response: UpdateProductResponse?) {
        DispatchQueue.main.async {
            MessageView.showMessage(message: SuccessMessage.addProduct, time: 1.7, verticalAlignment: .bottom)
        }
        // Updating the product like this as the get API is not refelecting the changes
        var newProduct = ProductListResponse()
        newProduct.id = response?.id ?? CharacterConstants.emptyIntValue
        newProduct.category = response?.category ?? CharacterConstants.emptyString
        newProduct.price = response?.price ?? CharacterConstants.emptyDoubleValue
        newProduct.image = response?.image ?? CharacterConstants.emptyString
        newProduct.description = response?.description ?? CharacterConstants.emptyString
        newProduct.title = response?.title ?? CharacterConstants.emptyString
        productListResponse?.append(newProduct)
        productTV.reloadData()
        productTV.scrollToBottom()
    }
    
    func didReceiveUpdateProductResponse(response: UpdateProductResponse?) {
        DispatchQueue.main.async {
            MessageView.showMessage(message: SuccessMessage.updateProduct, time: 1.5, verticalAlignment: .bottom)
        }
        // Updating the product like this as the get API is not refelecting the changes
        for (indexProduct, product) in productListResponse!.enumerated() {
            if product.id == response?.id {
                productListResponse?[indexProduct].id = response?.id
                productListResponse?[indexProduct].title = response?.title
                productListResponse?[indexProduct].image = response?.image
                productListResponse?[indexProduct].description = response?.description
                productListResponse?[indexProduct].price = response?.price
                productListResponse?[indexProduct].category = response?.category
            }
        }
        productTV.reloadData()
    }
    
    func didReceiveeCompanyData(response: ProductResponse?) {
        if response?.count != CharacterConstants.emptyIntValue {
            productListResponse = response
            productTV.reloadData()
        } else {
            DispatchQueue.main.async {
                MessageView.showMessage(message: ErrorMessage.dataNotFound, time: 1.0)
            }
        }
    }
    
    func didReceiveDeleteProductResponse(response: ProductListResponse?) {
        if response?.id != 0 {
            
            // Updating the product list like this as the get API is not refelecting the changes
            for (indexProduct, product) in productListResponse!.enumerated() {
                if product.id == response?.id {
                    productListResponse?.remove(at: indexProduct)
                }
            }
            DispatchQueue.main.async {
                self.productTV.reloadData()
                MessageView.showMessage(message: SuccessMessage.deleteProduct, time: 1.5, verticalAlignment: .bottom)
            }
            
        }else {
            DispatchQueue.main.async {
                MessageView.showMessage(message: ErrorMessage.errorDeletingProduct, time: 1.5, verticalAlignment: .bottom)
            }
        }
    }
}

