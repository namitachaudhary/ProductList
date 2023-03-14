//
//  AddProductViewModel.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 14/03/23.
//

import Foundation
protocol AddProductViewModelDelgate {
    func didReceiveAddProductResponse(response: UpdateProductResponse?)
}

struct AddProductViewModel {
    var delegate : AddProductViewModelDelgate?
    func addProduct(addProductRequest: UpdateProductRequest) {
        guard let url = URL(string: ApiEndpoints.productList) else {
            return
        }
        let httpUtility = HttpUtility()
        
        httpUtility.postMethod(requestUrl: url, requestBody: addProductRequest, resultType: UpdateProductResponse.self, isHud: true) { result in
            if(result.id != 0)
            {
                DispatchQueue.main.async {
                    self.delegate?.didReceiveAddProductResponse(response: result)
                }
            }
        }
    }
}
