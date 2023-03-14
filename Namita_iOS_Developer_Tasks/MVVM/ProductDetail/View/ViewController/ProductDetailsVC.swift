//
//  ProductDetailsVC.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 13/03/23.
//

import UIKit

protocol ActionItemDelegate {
    func performActionWith(actionType: String, productId: Int)
}

class ProductDetailsVC: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var productDetailTableView: UITableView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    // Public variables
    var prodictDetailViewModel = ProductDetailsViewModel()
    var productDetailsResponse: ProductDetailsResponse?
    var imageManager = ImageManager()
    var productId = CharacterConstants.emptyIntValue
    var delegate: ActionItemDelegate?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prodictDetailViewModel.delegate = self
        initialSetup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

}
