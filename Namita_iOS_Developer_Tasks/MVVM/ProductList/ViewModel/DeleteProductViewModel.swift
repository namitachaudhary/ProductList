//
//  DeleteProductViewModel.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 14/03/23.
//

import Foundation
protocol DeleteProductViewModelDelgate {
    func didReceiveDeleteProductResponse(response: ProductListResponse?)
}

struct DeleteProductViewModel {
    var delegate : DeleteProductViewModelDelgate?
    func deleteProductWith(productId: Int){
        let url = URL(string: "\(ApiEndpoints.productList)/\(productId)")!
        let httpUtility = HttpUtility()
        httpUtility.deleteMethod(requestUrl: url, isHud: true, resultType: ProductListResponse.self) { result in
            if(result?.id != 0)
            {
                DispatchQueue.main.async {
                  self.delegate?.didReceiveDeleteProductResponse(response: result)
                }
            }
        }
    }
}
