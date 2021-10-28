//
//  ProductListCoordinator.swift
//  ProductListing
//
//  Created by Dipak Pandey on 27/10/21.
//


import UIKit
import RxSwift

final class ProductListCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        
        let productService = ProductNetworkService.init(networkManager: NetworkManager())
        let viewModel = ProductListViewModel.init(productNetworkService: productService)
        let viewController = ProductListVC.initFromStoryboard()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setNavigationBarHidden(true, animated: true)
        viewController.viewModel = viewModel
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return Observable.never()
    }
    

}
