//
//  AppCoordinator.swift
//  ProductListing
//
//  Created by Dipak Pandey on 27/10/21.
//

import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.window.backgroundColor = UIColor.white
    }
    
    override func start() -> Observable<Void> {
        let productListVC = ProductListCoordinator(window: window)
        return self.coordinate(to: productListVC)
    }
}
