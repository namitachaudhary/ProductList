//
//  ProductListResponse.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 13/03/23.
//

import Foundation
struct ProductListResponse: Decodable {
    var id: Int?
    var title: String?
    var price: Double?
    var description: String?
    var category: String?
    var image: String?
    var rating: Rating?
}

// MARK: - Rating
struct Rating : Decodable {
    var rate: Double?
    var count: Int?
}

typealias ProductResponse = [ProductListResponse]
