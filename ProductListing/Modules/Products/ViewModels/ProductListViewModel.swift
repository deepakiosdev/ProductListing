//
//  ProductListViewModel.swift
//  ProductListing
//
//  Created by Dipak Pandey on 27/10/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProductListViewModelProtocol {
    func fetchProducts()
}

class ProductListViewModel {
    
    private let disposeBag = DisposeBag()
    let products: BehaviorRelay<[Product]> = BehaviorRelay.init(value: [])
    private let productNetworkService: ProductNetworkServiceProtocol!
    let isFetchingData: BehaviorRelay<Bool> = BehaviorRelay.init(value: true)
    let productsCount: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let errorMessage: BehaviorRelay<String> = BehaviorRelay.init(value: "")
    let isAPIRequestFalied: BehaviorRelay<Bool> = BehaviorRelay.init(value: false)

    init(productNetworkService: ProductNetworkServiceProtocol) {
        self.productNetworkService = productNetworkService
    }
    

    func getImageHeight(_ indexPath: IndexPath) -> Int {
        
        var height = products.value[indexPath.row].imageHeight
        
        if height > 0 {
            height = height / 5
        }
        return height
    }
    
    
    
    func fetchProducts() {
        isFetchingData.accept(true)
        do {
            try productNetworkService.fetchProductDetail()
                .subscribe(
                onNext: { [weak self] productDetail in
                    
                    self?.formatDisplayData(productDetail)
                    self?.isFetchingData.accept(false)
                },
                onError: { [weak self] error in
                    self?.handleError(PError.networkRequestFailed)
                    self?.isFetchingData.accept(false)
                },
                onCompleted: { [weak self] in
                    self?.isFetchingData.accept(false)
                }).disposed(by: disposeBag)
        }
        catch {
            isFetchingData.accept(false)
            handleError(PError.networkRequestFailed)
        }
    }
    
    
   private func formatDisplayData(_ productDetail: ProductDetail?) {
        
        guard let productDetail = productDetail else {
            return
        }

        products.accept(productDetail.products)
      
        var product = "Product"
        if productDetail.totalItemCount > 0 {
            product = "Product (\(productDetail.totalItemCount))"
        }
        productsCount.accept(product)

    }
    
    private func handleError(_ error: PError) {
        
        isAPIRequestFalied.accept(true)
        errorMessage.accept(error.description)
    }
    
}
