//
//  UIImage+LoadImage.swift
//  ProductListing
//
//  Created by Dipak Pandey on 27/10/21.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func setImage(from url: String, placeHolderImage: String?) {
        
        if !url.isEmpty, let imageURL = URL(string: url) {
            if let placeHolder = placeHolderImage, !placeHolder.isEmpty {
                self.sd_setImage(with:imageURL, placeholderImage: UIImage(named: placeHolder))
            } else {
                self.sd_setImage(with:imageURL)
            }
        }

    }
}
