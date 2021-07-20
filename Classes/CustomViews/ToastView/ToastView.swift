//
//  ToastView.swift
//  BeatyApp
//
//  Created by Sergey Kovalchyk on 20.10.2019.
//  Copyright © 2019 Sergey Kovalchyk. All rights reserved.
//

import UIKit

final class ToastView: BaseView {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    enum ToastType {
        case error
        case message
    }

    var type: ToastType = .error {
        didSet {
            setupToastView()
        }
    }

    @IBInspectable var text: String? {
        didSet {
            titleLabel.text = text
        }
    }

    @IBInspectable var numberOfLines: Int = 0 {
        didSet {
            titleLabel.numberOfLines = numberOfLines
            titleLabel.adjustsFontSizeToFitWidth = true
            titleLabel.minimumScaleFactor = 0.3
        }
    }

    func setupToastView() {
        switch type {
        case .error:
            backgroundColor = .red
            imageView.image = #imageLiteral(resourceName: "close")
        case .message:
            backgroundColor = .green
            imageView.image = #imageLiteral(resourceName: "check")
        }
    }
}
