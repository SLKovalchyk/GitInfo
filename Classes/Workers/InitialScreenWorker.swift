//
//  InitialScreenWorker.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import UIKit
import LGSideMenuController

struct InitialScreenWorker {
    func createWindow() -> UIWindow {
        let window = UIWindow()
        
        let configuration = Configuration.current
        if configuration.isUserFlowEnable {
            window.rootViewController = createMenuNavigationStack()
        } else {
            window.rootViewController = HomeSceneBuilder().build()
        }
        
        window.makeKeyAndVisible()
        return window
    }
    
    func createMenuNavigationStack() -> UIViewController {
        let rootHomeNavigationController = HomeSceneBuilder().build()
        let leftViewController = LeftMenuViewController()
        
        let menuVC = LGSideMenuController(rootViewController: rootHomeNavigationController,
                                          leftViewController: leftViewController,
                                          rightViewController: nil)
        menuVC.leftViewPresentationStyle = .slideBelow
        menuVC.leftViewWidth = 250.0
        return menuVC
    }
}
