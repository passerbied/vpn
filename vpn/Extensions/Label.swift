//
//  Label.swift
//  QuanZai
//
//  Created by i-chou on 6/28/16.
//  Copyright © 2016 i-chou. All rights reserved.
//

import UIKit

@IBDesignable

class Label: UILabel {
    
    var space: CGFloat = 3.0
    
    var firstLineHeadIndent: CGFloat = 0.0
    
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
    
    @IBInspectable var leftPadding: CGFloat = 0.0 {
        didSet {
            self.drawText(in: self.frame)
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0.0 {
        didSet {
            self.drawText(in: self.frame)
        }
    }
    
    @IBInspectable var bottomPadding: CGFloat = 0.0 {
        didSet {
            self.drawText(in: self.frame)
        }
    }
    
    @IBInspectable var topPadding: CGFloat = -2.0 {
        didSet {
            self.drawText(in: self.frame)
        }
    }
    
    func setLineSpace(_ space: CGFloat = 3.0, alignment textAlignment: NSTextAlignment = .left) {
        if self.text != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = space
            self.space = space
            let contentStr = NSMutableAttributedString(string: self.text!)
            contentStr.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, contentStr.length))
            self.attributedText = contentStr
            self.sizeToFit()
            self.textAlignment = textAlignment
        }
    }
    
    func changeFont(from startIndex: Int, range length:Int, color aColor: UIColor, font aFont: UIFont) {
        if self.text != nil {
            let range = NSMakeRange(startIndex, length)
//            let paragraphStyle = NSMutableParagraphStyle()
            let contentStr = NSMutableAttributedString(string: self.text!)
//            contentStr.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, contentStr.length))
            contentStr.addAttribute(NSAttributedStringKey.foregroundColor, value: aColor, range: range)
            contentStr.addAttribute(NSAttributedStringKey.font, value: aFont, range: range)
            self.attributedText = contentStr
//            self.sizeToFit()
//            self.textAlignment = textAlignment
        }
    }
    
    func changeFonts(from startIndexs: [Int], ranges lengths: [Int], colors colorList: [UIColor], fonts fontList: [UIFont]) {
        if self.text == nil {
            return
        }
        if startIndexs.count != lengths.count ||
            startIndexs.count != colorList.count ||
            startIndexs.count != fontList.count {
            return
        }
        let contentStr = NSMutableAttributedString(string: self.text!)
        for index in 0...startIndexs.count-1  {
            let range = NSMakeRange(startIndexs[index], lengths[index])
            contentStr.addAttribute(NSAttributedStringKey.foregroundColor, value: colorList[index], range: range)
            contentStr.addAttribute(NSAttributedStringKey.font, value: fontList[index], range: range)
        }
        self.attributedText = contentStr
        
    }
    
    func setAttributedText(with paragraphStyle: NSMutableParagraphStyle) {
        if self.text != nil {
            let contentStr = NSMutableAttributedString(string: self.text!)
            contentStr.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, (self.text?.count)!))
            self.attributedText = contentStr
        }
    }
    
    func requiredHeight() -> CGFloat{
        
        let label:UILabel = UILabel(frame: ccr(0, 0, self.frame.width-self.leftPadding-self.rightPadding, CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        let contentStr = NSMutableAttributedString(string: self.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = self.space
        paragraphStyle.firstLineHeadIndent = self.firstLineHeadIndent
        contentStr.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, (self.text?.count)!))
        contentStr.addAttribute(NSAttributedStringKey.font, value: self.font, range: NSMakeRange(0, (self.text?.count)!))
        label.attributedText = contentStr
        label.font = self.font
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        self.lineBreakMode = .byWordWrapping
        self.attributedText = contentStr
        self.sizeToFit()
        
        return label.frame.height
    }
    
    func setAttatchImage(image: UIImage, atLastOfString string: String)
    {
        let attributedMString = NSMutableAttributedString(string: string)
        let attach = NSTextAttachment()
        attach.image = image
        attach.bounds = CGRect(x: 2, y: -2, width: 20, height: 20)
        
        let imageString = NSAttributedString(attachment: attach)
        attributedMString.append(imageString)
        self.attributedText = NSAttributedString(attributedString: attributedMString)
        self.sizeToFit()
    }
    
    override func drawText(in rect: CGRect) {
        
        let insets = UIEdgeInsets.init(top: self.topPadding, left: self.leftPadding, bottom: self.bottomPadding, right: self.rightPadding)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
