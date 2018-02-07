//
//  UITableView+Extension.swift
//  vpn
//
//  Created by i-chou on 2018/2/6.
//  Copyright © 2018年 i-chou. All rights reserved.
//

import Foundation

private var emptyImageAssociationKey: UInt8 = 0
private var emptyTap: (() -> Void)?

extension UITableView {

    private var emptyImageView: UIImageView? {
        get {
            return objc_getAssociatedObject(self, &emptyImageAssociationKey) as? UIImageView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &emptyImageAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    func setEmptyView(show: Bool, emptyImage: UIImage = IMG("default-img"), tap: @escaping (() -> Void) = {}) {
        if show {
            if emptyImageView == nil {
                emptyImageView = UIImageView.init(frame: ccr(0, 0, k_SCREEN_W*2/3, emptyImage.size.height/emptyImage.size.width*k_SCREEN_W*2/3))
            }
            emptyImageView?.centerX = k_SCREEN_W/2
            emptyImageView?.y = 100
            emptyImageView?.image = emptyImage

            if emptyImageView?.superview == nil {
                self.addSubview(emptyImageView!)
            }
            emptyTap = tap
            let tapGes = UITapGestureRecognizer()
            tapGes.addTarget(self, action: #selector(emptyTapGestTapped))
            emptyImageView?.addGestureRecognizer(tapGes)
            emptyImageView?.isUserInteractionEnabled = true
        }else {
            if emptyImageView != nil {
                emptyImageView?.removeFromSuperview()
            }
        }

    }

    @objc private func emptyTapGestTapped() {
        emptyTap?()
    }

}
