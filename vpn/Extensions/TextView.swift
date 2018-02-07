//
//  TextView.swift
//  Talkie
//
//  Created by i-chou on 30/09/2016.
//  Copyright © 2016 i-chou. All rights reserved.
//

@IBDesignable
class TextView: UITextView {
    
    @IBInspectable var leftPadding: CGFloat = 0.0 {
        didSet {
            let insets = UIEdgeInsets.init(top: self.topPadding, left: self.leftPadding, bottom: 0, right: self.rightPadding)
            self.textContainerInset = insets
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0.0 {
        didSet {
            let insets = UIEdgeInsets.init(top: self.topPadding, left: self.leftPadding, bottom: 0, right: self.rightPadding)
            self.textContainerInset = insets
        }
    }
    
    @IBInspectable var topPadding: CGFloat = 2.0 {
        didSet {
            let insets = UIEdgeInsets.init(top: self.topPadding, left: self.leftPadding, bottom: 0, right: self.rightPadding)
            self.textContainerInset = insets
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor() {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable var shadowOffset: CGSize = ccs(0,0) {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
}
