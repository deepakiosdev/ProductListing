//
//  UIView+IB.swift
//  ProductListing
//
//  Created by Dipak Pandey on 28/10/21.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: Double {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    
    /*
    * This method add shadow effect and corner radius on caller view.
    * Note 1- If default IB inspectable methods does not work then only call this mehtod manually.
    * Note 2- Before calling to this metod first need to set required propetries either from IB or programmatically.
    * View inside have image view in that case may be all above will not work them use this method
    */

    func addShadowWithRadius() {
        self.layer.cornerRadius = self.cornerRadius
       // self.layer.masksToBounds = YES;
        
        self.layer.shadowColor = self.shadowColor?.cgColor

        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowRadius = self.shadowRadius

        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.masksToBounds = false
        
    }
}
