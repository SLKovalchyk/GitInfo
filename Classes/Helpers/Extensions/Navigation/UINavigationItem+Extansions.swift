//
//  UINavigationItem+Extansions.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import Foundation
import ObjectiveC
import UIKit

import LGSideMenuController

extension UINavigationItem {
    func setImageAsTitle(_ image: UIImage? = #imageLiteral(resourceName: "github")) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        titleView = imageView
    }
    
    enum LeftNavigationButtonType {
        case None
        case Back
        case Menu
    }

    enum RightNavigationButtonType {
        case None
        case Filter
    }

    func setRightBarButtonItem(type : RightNavigationButtonType, target : UIViewController) {
        viewController = target
        rightBarButtonItem = nil

        switch type {
        case .None:
            break
        case .Filter:
            rightBarButtonItem = customFilterItem()
        }
    }

    func setLeftButtonType(type : LeftNavigationButtonType, target : UIViewController) {
        setHidesBackButton(true, animated: false)
        viewController = target
        leftBarButtonItem = nil
        
        switch type {
        case .None: leftBarButtonItem = nil
        case .Back: leftBarButtonItem = customBackButtonItem()
        case .Menu: leftBarButtonItem = customMenuButtomItem()
        }
    }

    func setTitle(title : String) {
        self.titleView = nil
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleView = titleLabel
    }
    
    
    private struct AssociatedKeys {
        static var VC = "VC"
    }

    private var viewController : UIViewController? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.VC) as? UIViewController
        }
        set {
             objc_setAssociatedObject(self, &AssociatedKeys.VC, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private func customBackButtonItem () -> UIBarButtonItem {
        return barButtonItem(image: #imageLiteral(resourceName: "arrow"), action: #selector(goBack))
    }

    private func customCancaleButtomItem() -> UIBarButtonItem {
        return barButtonItem(title:"Cancel", acton: #selector(goBack))
    }

    private func customMenuButtomItem() -> UIBarButtonItem {
        return barButtonItem(image: #imageLiteral(resourceName: "menu"), action: #selector(showMenu))
    }

    private func customFilterItem() -> UIBarButtonItem {
        return barButtonItem(image: #imageLiteral(resourceName: "filter"), action: #selector(filterPresed))
    }
    
    func barButtonItem(image: UIImage, action : Selector) -> UIBarButtonItem {
        let button : UIButton = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: 36,
                              height: 36)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        let item : UIBarButtonItem = UIBarButtonItem.init(customView: button)
        item.tintColor = .white
        return item
    }

    func barButtonItem(title : String, acton : Selector) -> UIBarButtonItem {
        let button : UIButton = UIButton.init(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.sizeToFit()
        button.addTarget(self, action: acton, for: .touchUpInside)
        let item : UIBarButtonItem = UIBarButtonItem.init(customView: button)
        item.tintColor = .white
        return item
    }

    //MARK: - Show methods -
    @objc func showMenu() {
        if let menu = viewController?.sideMenuController {
            menu.showLeftViewAnimated(sender: nil)
        }
    }
    
    @objc func filterPresed() {
        if viewController?.responds(to: #selector(filterPresed)) != false {
            viewController?.perform(#selector(filterPresed))
            return
        }
        assert(false, "Subclasses must override the method")
    }
    
    @objc func goBack() {
        if viewController?.responds(to: #selector(goBack)) != false {
            viewController?.perform(#selector(goBack))
            return
        }
        
        if (viewController?.navigationController?.viewControllers.count)! > 1 {
            viewController?.navigationController?.popViewController(animated: true)
        }
        else if viewController?.navigationController?.viewControllers.count == 1 && ((viewController?.navigationController?.presentingViewController) != nil) {
            _ = viewController?.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}
