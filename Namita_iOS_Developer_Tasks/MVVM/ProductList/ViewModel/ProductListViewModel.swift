//
//  ViewModel.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 13/03/23.
//

import Foundation
protocol ProductListViewModelDelgate {
    func didReceiveeCompanyData(response: ProductResponse?)
}

struct ProductListViewModel {
    var delegate : ProductListViewModelDelgate?
    func getCompanyList(){
        let url = URL(string: ApiEndpoints.productList)!
        let httpUtility = HttpUtility()
        httpUtility.getApiData(requestUrl: url,isHud: true, resultType: ProductResponse.self) { response in
            if(response?.count != 0)
            {
                DispatchQueue.main.async {
                    self.delegate?.didReceiveeCompanyData(response: response)
                }
            }
        }
    }
}
