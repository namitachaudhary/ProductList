//
//  ProductDetailsViewModel.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 14/03/23.
//

import Foundation

protocol ProductDetailsViewModelDelgate {
    func didReceiveProductDetails(response: ProductDetailsResponse?)
}

struct ProductDetailsViewModel {
    var delegate : ProductDetailsViewModelDelgate?
    func getProductDetails(productId: Int){
        let url = URL(string: "\(ApiEndpoints.productList)/\(productId)")!
        let httpUtility = HttpUtility()
        httpUtility.getApiData(requestUrl: url,isHud: true, resultType: ProductDetailsResponse.self) { response in
            if(response?.id != 0)
            {
                DispatchQueue.main.async {
                    self.delegate?.didReceiveProductDetails(response: response)
                }
            }
        }
    }
}
