//
//  ProductCell.swift
//  CustomCollectionViewLayout
//
//  Created by Dipak Pandey on 22/10/21.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblViewCount: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateCornerRadiusAndShadow()
    }

    private func updateCornerRadiusAndShadow() {
        contentView.layer.cornerRadius = 8.0
        contentView.layer.masksToBounds = true
        self.addShadowWithRadius()
        lblPrice.layer.cornerRadius = 4.0
        lblPrice.layer.masksToBounds = true

    }
    
    var product: Product? {
        didSet {
            if let product = product {
                imgView?.setImage(from: product.imageURL, placeHolderImage: Constants.Image.placeholderImage)
                lblPrice?.text = "₹\(product.price)"
                lblViewCount?.text = "\(product.viewsCount)"
            }
        }
    }
    
}
