//
//  Button.swift
//  QuanZai
//
//  Created by i-chou on 6/29/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

import UIKit

typealias ActionBlock = ((_ btn: Button) -> ())

@IBDesignable

class Button: UIButton {
    
    var onTapUpBlock: ActionBlock?
    var onTapDownBlock: ActionBlock?
    var onTapCancelBlock: ActionBlock?
    
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
    
    class func `init`(frame: CGRect, onTouchUp actionBlock: ActionBlock?) -> Button {
        let btn = Button(frame: frame)
        btn.addTarget(btn, action: #selector(onTouchUp), for: .touchUpInside)
        btn.onTapUpBlock = actionBlock
        return btn
    }
    
    class func `init`(frame: CGRect,
                      normal image: UIImage?,
                      selected selectedImage: UIImage?,
                      disabled disabledImage: UIImage? = nil,
                      onTouchDown actionDownBlock: ActionBlock?,
//                      onTouchCancel actionCancelBlock: ActionBlock?,
                      onTouchUp actionUpBlock: ActionBlock?) -> Button {
        let btn = Button(frame: frame)
        btn.contentHorizontalAlignment = .center
        if image != nil {
            btn.setImage(image, for: .normal)
        }
        if selectedImage != nil {
            btn.setImage(selectedImage, for: .selected)
            btn.setImage(selectedImage, for: .highlighted)
        }
        if disabledImage != nil {
            btn.setImage(disabledImage, for: .disabled)
        }
        btn.addTarget(btn, action: #selector(onTouchUp), for: .touchUpInside)
        btn.addTarget(btn, action: #selector(onTouchDown), for: .touchDown)
//        btn.addTarget(btn, action: #selector(onTouchUp), for: .touchUpOutside)
        btn.addTarget(btn, action: #selector(onTouchUp), for: .touchCancel)
        btn.addTarget(btn, action: #selector(onTouchUp), for: .touchDragExit)
        btn.onTapUpBlock = actionUpBlock
        btn.onTapDownBlock = actionDownBlock
//        btn.onTapCancelBlock = actionCancelBlock
        return btn
    }
    
    class func `init`(frame: CGRect,
                      withTitle title: String?,
                      fontSize font: UIFont?,
                      titleAlignment alignment: UIControlContentHorizontalAlignment?,
                      titleColor title_color: UIColor?,
                      backgroundColor bg_color: UIColor?,
                      onTouchUp actionBlock: ActionBlock?) -> Button {
        let btn = Button(frame: frame)
        btn.cornerRadius = 4.0
        if bg_color != nil {
            btn.backgroundColor = bg_color
        } else {
            btn.backgroundColor = kColor_Red
        }
        if title_color != nil {
            btn.setTitleColor(title_color, for: .normal)
        } else {
            btn.setTitleColor(.white, for: .normal)
        }
        if alignment != nil {
            btn.contentHorizontalAlignment = alignment!
        } else {
            btn.contentHorizontalAlignment = .center
        }
        if font != nil {
           btn.titleLabel?.font = font
        } else {
            btn.titleLabel?.font = HS_FONT(15)
        }
        btn.setTitle(title, for: .normal)
        btn.addTarget(btn, action: #selector(onTouchUp), for: .touchUpInside)
        btn.onTapUpBlock = actionBlock
        return btn
    }
    
    @objc func onTouchDown() {
        if self.onTapDownBlock != nil {
            self.onTapDownBlock!(self)
        }
    }
    
    @objc func onTouchUp() {
        if self.onTapUpBlock != nil {
          self.onTapUpBlock!(self)
        }
    }
    
    func onTouchCancel() {
        if self.onTapCancelBlock != nil {
            self.onTapCancelBlock!(self)
        }
    }
    
}

extension Button {
    
    @objc func set(image anImage: UIImage?, title: NSString, titlePosition: UIViewContentMode, additionalSpacing: CGFloat, state: UIControlState){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title as String?, for: state)
    }
    
    private func positionLabelRespectToImage(title: NSString, position: UIViewContentMode, spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedStringKey.font: titleFont!])
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
