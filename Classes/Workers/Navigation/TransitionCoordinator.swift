//
//  TransitionCoordinator.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 20.07.2021.
//

import Foundation
import UIKit

class TransitionCoordinator: NSObject, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let simpleOver = SimpleOver()
        simpleOver.popStyle = (operation == .pop)
        return simpleOver
    }

}
