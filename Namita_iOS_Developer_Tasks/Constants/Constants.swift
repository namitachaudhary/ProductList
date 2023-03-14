//
//  Common.swift
//  MVVMDemo
//
//  Created by Admin on 14/03/23.
//

import Foundation

struct ApiEndpoints
{
    static let productList = "https://fakestoreapi.com/products"
   
}

struct ErrorMessage {
    static let dataNotFound = "Data Not Found"
    static let errorDeletingProduct = "Error Deleting the product."
    static let errorConvertingModel = "Error: Trying to convert model to JSON data"
    static let errorCallingPutAPI = "Error: error calling PUT"
    static let errorDataNotReceived = "Error: Did not receive data"
    static let requestFailed = "Error: HTTP request failed"
    static let errorJsonConversion = "Error: Cannot convert data to JSON object"
    static let errorPrettyJsonConversion = "Error: Cannot convert JSON object to Pretty JSON data"
    static let errorPrintError = "Error: Could print JSON in String"    
}

struct SuccessMessage {
    static let deleteProduct = "Product deleted successfully"
    static let updateProduct = "Product updated successfully"
    static let addProduct = "Product Added successfully"
}

enum ViewControllersIdentifier {
    case productDetailsVC
    
    var value: String {
        return "\(self)".firstUppercased
    }
}

struct ProductRequestConstant {
    static let productTitle = "New Product"
    static let productPrice = 13.0
    static let productDescription = "Lorem Impsum Sit amet"
    static let productImage = "https://i.pravatar.cc"
    static let productCategory = "Electronics"
}

enum StoryBoardName {
    case main
    
    var value: String {
        return "\(self)".firstUppercased
    }
}

enum TableViewCellIdentifier {
    case descriptionTVCell
    case productListTVCell
    
    var value: String {
        return "\(self)".firstUppercased
    }
}

enum ProductActionType {
    static let deleteProduct = "Delete"
    static let updateProduct = "Update"
}

enum CharacterConstants {
    static let emptyString = ""
    static let emptyDoubleValue = 0.0
    static let emptyIntValue = 0
}

enum ProductListConstants {
    static let tableViewRowHeight = 82.0
}

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
}
