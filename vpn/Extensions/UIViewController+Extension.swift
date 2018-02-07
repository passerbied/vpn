//
//  UIViewController+Extension.swift
//  vpn
//
//  Created by i-chou on 2018/2/6.
//  Copyright © 2018年 i-chou. All rights reserved.
//

import Foundation

private var navBackColorAssociationKey: UInt8 = 0
private var navShadowImageAssociationKey: UInt8 = 0 << 1
private var navTintColorAssociationKey: UInt8 = 0 << 2

open class navConfig {
    var nBackColor: UIColor?
    var nShadowImage: UIImage?
    var nTintColor: UIColor?
    var nIsTrunslate: Bool?
    convenience init(backColor: UIColor, shadowImage: UIImage, tintColor: UIColor, isTrunslate: Bool) {
        self.init()
        self.nBackColor = backColor
        self.nShadowImage = shadowImage
        self.nTintColor = tintColor
        self.nIsTrunslate = isTrunslate
    }
}


extension UIViewController {

    private var navBackColor: UIColor! {
        get {
            return objc_getAssociatedObject(self, &navBackColorAssociationKey) as? UIColor
        }
        set(newValue) {
            objc_setAssociatedObject(self, &navBackColorAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    private var navShadowImage: UIImage! {
        get {
            return objc_getAssociatedObject(self, &navShadowImageAssociationKey) as? UIImage
        }
        set(newValue) {
            objc_setAssociatedObject(self, &navShadowImageAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    private var navTintColor: UIColor! {
        get {
            return objc_getAssociatedObject(self, &navTintColorAssociationKey) as? UIColor
        }
        set(newValue) {
            objc_setAssociatedObject(self, &navTintColorAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    func setNavBar(isHidden: Bool, config: navConfig = k_AppDelegate.defaultNavConfig) {

        if isHidden {
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.tintColor = .white

        }else {
            self.navigationController?.navigationBar.isTranslucent = config.nIsTrunslate!
            self.navigationController?.navigationBar.shadowImage = config.nShadowImage!
            self.navigationController?.navigationBar.setBackgroundImage(UIImage.image(with: config.nBackColor!, size: ccs(k_SCREEN_W, 64)), for: .default)
            self.navigationController?.navigationBar.tintColor = config.nTintColor

        }
    }


}
