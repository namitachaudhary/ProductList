//
//  ProductDetailsResponse.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 14/03/23.
//

import Foundation

struct ProductDetailsResponse: Decodable {
    let id: Int?
    let title: String?
    let price: Double?
    let description, category: String?
    let image: String?
    let rating: ProductRating?
}

// MARK: - Rating
struct ProductRating: Decodable {
    let rate: Double?
    let count: Int?
}
