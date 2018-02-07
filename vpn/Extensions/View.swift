//
//  View.swift
//  QuanZai
//
//  Created by i-chou on 6/24/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

import UIKit

@IBDesignable

class View: UIView {
    
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
/*
extension UIView {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch: UITouch = touches.first {
            let center: CGPoint = touch.location(in: self)
            FingerWaveView.show(in: self, center: center)
        }
    }
 
//    
//    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch: UITouch = touches.first {
//            let center: CGPoint = touch.location(in: self)
//            FingerWaveView.show(in: self, center: center)
//        }
//        super.touchesEnded(touches, with: event)
//    }
}
*/
