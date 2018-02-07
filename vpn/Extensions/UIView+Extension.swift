//
//  UIView+Extension.swift
//  vpn
//
//  Created by i-chou on 2018/2/6.
//  Copyright © 2018年 i-chou. All rights reserved.
//

import Foundation
import UIKit
import ESTabBarController_swift


extension UIView {

    func showBadgeAt(_ offset:CGPoint, count:Int, frameFactor:CGFloat = 1) {
        var badge : ESTabBarItemBadgeView?
        for view in self.subviews {
            if view.classForCoder == ESTabBarItemBadgeView.classForCoder() {
                if count == 0 {
                    view.removeFromSuperview()
                    return
                }else {
                    badge = (view as! ESTabBarItemBadgeView)
                }
            }
        }

        if badge == nil {
            badge = ESTabBarItemBadgeView.init(frame: ccr(0, 0, 16*frameFactor, 16*frameFactor))
            badge?.badgeColor = UIColor.red
        }
        badge?.badgeValue = String(describing: count)
        badge?.badgeLabel.font = B_FONT(11)
        let size = badge?.sizeThatFits(self.frame.size)
        badge?.center = ccp(self.width + offset.x, 0 + offset.y)
        badge?.frame.size = size!
        if count == 0 {
            return
        }

        self.addSubview(badge!)
    }

    @objc private func tapped() {
        k_KEY_WINDOW?.endEditing(true)
    }
    
    func addTapRemoveEdit() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapped))
        self.addGestureRecognizer(tap)
    }
}


