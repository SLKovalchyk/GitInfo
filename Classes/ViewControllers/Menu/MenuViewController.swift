//
//  MenuViewController.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import UIKit
import LGSideMenuController

class MenuViewController: LGSideMenuController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootViewStatusBarStyle = .lightContent
        self.leftViewStatusBarStyle = .lightContent
        isLeftViewSwipeGestureEnabled = false
        isLeftViewSwipeGestureDisabled = true
    }
}
