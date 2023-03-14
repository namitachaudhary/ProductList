//
//  ProductListVC.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 13/03/23.
//

import Foundation

class ImageRequestManager {
    static let shared = ImageRequestManager()
    private let imageSessionManager = URLSession(configuration: .default)
    typealias response = ((Data?, Error?) -> ())
    
    func getImageData(thumbnailURL:URLRequest, completion:@escaping response) {
        imageSessionManager.dataTask(with: thumbnailURL) { data, _, error in
            completion(data, error)
        }.resume()
    }
}
