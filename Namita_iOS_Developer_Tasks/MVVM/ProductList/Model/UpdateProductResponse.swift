//
//  UpdateProductResponse.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 14/03/23.
//

import Foundation

struct UpdateProductResponse: Decodable {
    let title: String
    let id: Int
    let description, category: String
    let image: String
    let price: Double
}
