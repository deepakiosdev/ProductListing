//
//  ProductListVC.swift
//  ProductListing
//
//  Created by Dipak Pandey on 27/10/21.
//

import UIKit
import RxSwift

class ProductListVC: UIViewController, StoryboardInitializable {
    
    @IBOutlet weak var lblProductCount: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblErrorMessage: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var viewModel: ProductListViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        intializeView()
    }

    //MARK: Intialization methods
    private func intializeView() {
        viewModel.fetchProducts()
        setupCollectionView()
        setupBinding()
    }
    
}

//MARK: Binding methods
extension ProductListVC {
    
    private func setupBinding() {
        
        viewModel.products
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] products in
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.productsCount
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] itemCount in
                self?.lblProductCount.text = itemCount
            })
            .disposed(by: disposeBag)
        
        viewModel.isFetchingData
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] isFetching in
                self?.activityIndicator.isHidden = !isFetching
            })
            .disposed(by: disposeBag)
        
        viewModel.isAPIRequestFalied
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] isAPIRequestFalied in
                self?.lblErrorMessage.isHidden = !isAPIRequestFalied
            })
            .disposed(by: disposeBag)

        viewModel.errorMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] message in
                self?.lblErrorMessage.text = message
            })
            .disposed(by: disposeBag)

        
    }

}

//MARK: UICollectionView Methods
extension ProductListVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func setupCollectionView() {
        if let layout = collectionView?.collectionViewLayout as? DynamicLayout {
            layout.delegate = self
        }
        registerCell()
    }
    
    private func registerCell() {
        let cellIdentifier = String(describing: ProductCell.self)
        let cellNib = UINib(nibName: String(describing: ProductCell.self), bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.value.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductCell.self), for: indexPath as IndexPath) as! ProductCell
        cell.product = viewModel.products.value[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension ProductListVC: DynamicLayoutDelegate {

    func collectionView( _ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
          let height = viewModel.getImageHeight(indexPath)
          return CGFloat(height)
      }
}
