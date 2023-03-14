//
//  ProductListVC.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 13/03/23.
//

import UIKit

class ProductListVC: UIViewController {

    // IBOutlest
    @IBOutlet weak var headerTittleLbl: UILabel!
    @IBOutlet weak var productTV: UITableView!

    // Public Variables
    var productListResponse : ProductResponse?
    var productListVM = ProductListViewModel()
    var deleteProductViewModel = DeleteProductViewModel()
    var updateProductViewModel = UpdateProductViewModel()
    var addProductViewModel = AddProductViewModel()
    
    let commonRequest = UpdateProductRequest(title: ProductRequestConstant.productTitle, price: ProductRequestConstant.productPrice, description: ProductRequestConstant.productDescription, image: ProductRequestConstant.productImage, category: ProductRequestConstant.productCategory)
 
}

//MARK: UIVicontroller Life Cycle
extension ProductListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        productListVM.delegate = self
        deleteProductViewModel.delegate = self
        updateProductViewModel.delegate = self
        addProductViewModel.delegate = self
        initialSetUp()
    }
}



