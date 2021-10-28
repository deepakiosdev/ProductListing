//
//  Product.swift
//  ProductListing
//
//  Created by Dipak Pandey on 27/10/21.
//

import Foundation


struct ProductDetail {
    
    var products: [Product] = [Product]()
    var message: String = ""
    var totalItemCount: Int = 0
    var currentPage: Int = 0
    var totalPages: Int = 0

}

extension ProductDetail: Decodable {
    
    enum CoadingKeys: String, CodingKey {
        
        case products = "data"
        case message
        case meta
    }
    
    enum MetaDataKeys: String, CodingKey {
        case totalItemCount = "total_count"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CoadingKeys.self)
        products = try container.decodeIfPresent([Product].self, forKey: .products) ?? []
        message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
        
        let metaDataContainer = try? container.nestedContainer(keyedBy: MetaDataKeys.self, forKey: .meta)
        totalItemCount = try metaDataContainer?.decodeIfPresent(Int.self, forKey: .totalItemCount) ?? 0
        currentPage = try metaDataContainer?.decodeIfPresent(Int.self, forKey: .currentPage) ?? 0
        totalPages = try metaDataContainer?.decodeIfPresent(Int.self, forKey: .totalPages) ?? 0
    }
    
}

struct Product {
    var id: Int = 0
    var name: String = ""
    var description: String = ""
    var price: String = ""
    var viewsCount: Int = 0
    var imageURL: String = ""
    var imageHeight: Int = 0
}

extension Product: Decodable {
    
    enum CoadingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case viewsCount = "views_count"
        case image
    }
    
    enum ImageKeys: String, CodingKey {
       case imageURL = "original_image_url"
        //case imageURL = "medium_version_url"
       //case imageURL = "logo_version_url"

        case imageHeight = "height"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CoadingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        price = try container.decodeIfPresent(String.self, forKey: .price) ?? ""
        viewsCount = try container.decodeIfPresent(Int.self, forKey: .viewsCount) ?? 0

        let imageContainer = try? container.nestedContainer(keyedBy: ImageKeys.self, forKey: .image)
        imageURL = try imageContainer?.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        imageHeight = try imageContainer?.decodeIfPresent(Int.self, forKey: .imageHeight) ?? 0
    }
    
}
