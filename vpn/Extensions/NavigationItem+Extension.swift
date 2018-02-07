//
//  navigationItem+Extension.swift
//  vpn
//
//  Created by i-chou on 2018/2/6.
//  Copyright © 2018年 i-chou. All rights reserved.
//

import Foundation


extension UINavigationItem {

    func showLeftBarItem(_ views: UIView... , edge:CGFloat , space:CGFloat) {

        var itemsArr : [UIBarButtonItem] = []
        let edgeItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        edgeItem.width = edge-10
        itemsArr.append(edgeItem)

        for view in views {
            let barItem = UIBarButtonItem.init(customView: view)
            let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            spaceItem.width = space
            itemsArr.append(barItem)
            itemsArr.append(spaceItem)
        }

        self.setLeftBarButtonItems(itemsArr, animated: false)
    }

    func showRightBarItem(_ views: UIView... , edge:CGFloat , space:CGFloat) {

        var itemsArr : [UIBarButtonItem] = []
        let edgeItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        edgeItem.width = edge-10
        itemsArr.append(edgeItem)

        for view in views {
            let barItem = UIBarButtonItem.init(customView: view)
            let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            spaceItem.width = space
            itemsArr.append(barItem)
            itemsArr.append(spaceItem)
        }

        self.setRightBarButtonItems(itemsArr, animated: false)
    }

}
