//
//  AddProductRequest.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 14/03/23.
//

import Foundation

// Create model
struct UpdateProductRequest: Codable {
    let title: String?
    let price: Double?
    let description: String?
    let image: String?
    let category: String?
}
