//
//  BaseViewController.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 20.07.2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    var errorBannerViewTopAnchor: NSLayoutYAxisAnchor { return view.safeAreaLayoutGuide.topAnchor }
    var errorBannerViewTopPadding: CGFloat { return 0 }
    
    //MARK: - Toast View -
    fileprivate var toastView: ToastView?

    fileprivate func generateToastView(type : ToastView.ToastType,
                                       message : String) -> ToastView {
        let toast  = ToastView()
        view.addSubview(toast)
        toast.isHidden = false
        toast.text = message
        toast.type = .error
        toast.anchor(top: errorBannerViewTopAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     topConstant: errorBannerViewTopPadding)
        return toast
    }

    func showToastAlert(type : ToastView.ToastType,
                        message : String) {
        hideToast(toastView, animation: false)

        let newToast = generateToastView(type: type, message: message)
        toastView = newToast

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.hideToast(newToast, animation: true)
        }
    }

    fileprivate func hideToast(_ toastView: ToastView?, animation: Bool) {
        guard let toastView = toastView else { return }
        let duration: TimeInterval = animation ? 0.4 : 0
        UIView.animate(withDuration: duration, animations: {
            toastView.alpha = 0
        }) { (finished) in
            if finished {
                toastView.removeFromSuperview()
            }
        }
    }

    func showToastError(message : String) {
        self.showToastAlert(type: .error, message: message)
    }
}
