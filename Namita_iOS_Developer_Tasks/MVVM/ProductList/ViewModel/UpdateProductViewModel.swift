//
//  UpdateProductViewModel.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 14/03/23.
//

import Foundation

protocol UpdateProductViewModelDelgate {
    func didReceiveUpdateProductResponse(response: UpdateProductResponse?)
}

struct UpdateProductViewModel {
    var delegate : UpdateProductViewModelDelgate?
    func updateProduct(productId: Int, updateProductRequest: UpdateProductRequest) {
        let url = URL(string: "\(ApiEndpoints.productList)/\(productId)")!
        let httpUtility = HttpUtility()
  
        httpUtility.putMethod(requestUrl: url, uploadDataModel: updateProductRequest, isHud: true, resultType: UpdateProductResponse.self) { result in
            if(result?.id != 0)
            {
                DispatchQueue.main.async {
                  self.delegate?.didReceiveUpdateProductResponse(response: result)
                }
            }
        }
    }
}
