//
//  SimpleOver.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 20.07.2021.
//

import Foundation
import UIKit

class SimpleOver: NSObject, UIViewControllerAnimatedTransitioning {

    var popStyle: Bool = false

    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if popStyle {
            animatePop(using: transitionContext)
            return
        }

        guard let fromVC = transitionContext.viewController(forKey: .from) ,
              let toVC = transitionContext.viewController(forKey: .to)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        transitionContext.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext)*0.8,
            animations: {
                fromVC.view.alpha = 0
        }, completion: { _ in
            transitionContext.containerView.bringSubviewToFront(fromVC.view)
            fromVC.view.alpha = 1
            transitionContext.completeTransition(true)
        })
    }

    func animatePop(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else {
                transitionContext.completeTransition(true)
                return
        }

        transitionContext.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromVC.view.alpha = 0
        }, completion: { _ in
            transitionContext.containerView.bringSubviewToFront(fromVC.view)
            fromVC.view.alpha = 1
            transitionContext.completeTransition(true)
        })
    }
}
