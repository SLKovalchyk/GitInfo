//
//  UIViewController+Navigation.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import UIKit

public extension UIViewController {
    func wrapInNavigationController(
        hideNavBar: Bool = false,
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen) -> UINavigationController {
        
        let nc = UINavigationController()
        nc.navigationBar.isHidden = hideNavBar
        nc.modalPresentationStyle = modalPresentationStyle
        nc.viewControllers = [self]
        return nc
    }
}

public extension NSObject {
    class var className: String {
        return String(describing: self)
    }

    @objc class var nibName: String {
        return className
    }

    var className: String {
        return type(of: self).className
    }
}
