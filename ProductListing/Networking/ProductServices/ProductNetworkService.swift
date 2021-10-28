//
//  ProductNetworkServiceProtocol.swift
//  ProductListing
//
//  Created by Dipak Pandey on 27/10/21.
//

import Foundation
import RxSwift

protocol ProductNetworkServiceProtocol {
    func fetchProductDetail() throws -> Observable<ProductDetail>
}

struct ProductNetworkService {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension ProductNetworkService: ProductNetworkServiceProtocol {
    
    func fetchProductDetail() throws -> Observable<ProductDetail> {
        return networkManager.fetch(using: try NetworkRequest.getProductDetail.urlRequest())
        
    }
}

