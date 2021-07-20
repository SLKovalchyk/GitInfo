//
//  UIButton+Extensions.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import Foundation
import UIKit

extension UIButton {
    @IBInspectable var isRightImage: Bool {
        set (newValue) {
            if newValue == true {
                self.imageView?.contentMode = .scaleAspectFit

                if let image = self.imageView?.image {
                    let imageSize: CGSize = image.size
                    self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                        left: -15,
                                                        bottom: 0,
                                                        right: 0)
                    self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                        left: self.bounds.width - imageSize.width - 15,
                                                        bottom: 0,
                                                        right: 15)
                }
                else {
                    self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
                }
            }
        }
        get {
            return self.isRightImage
        }
    }

    @IBInspectable var isTitleResizeFont: Bool {
        set {
            self.titleLabel?.minimumScaleFactor = 0.5;
            self.titleLabel?.numberOfLines = 1;
            self.titleLabel?.lineBreakMode = .byWordWrapping;
            self.titleLabel?.textAlignment = .center;
        }
        get {
            return self.isTitleResizeFont;
        }
    }
    @IBInspectable var titleNumberLines: Int {
        set {
            self.titleLabel?.numberOfLines = newValue;
        }
        get {
            return self.titleNumberLines;
        }
    }

    @IBInspectable var isTitleCenter: Bool {
        set {
            if newValue == true {
                self.titleLabel?.textAlignment = .center;
            }
        }
        get {
            return self.isTitleCenter;
        }
    }

    @IBInspectable var isTitleUnderImage: Bool {
        set {
            if newValue == true {
                self.titleLabel?.numberOfLines = 0
                self.titleLabel?.textAlignment = .center
                self.titleLabel?.minimumScaleFactor = 0.8
                // the space between the image and text
                let spacing: CGFloat = 4
                // lower the text and push it left so it appears centered
                //  below the image
                let imageSize: CGSize = self.imageView?.image?.size ?? CGSize.zero
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0,
                                                         left: -imageSize.width + 0,
                                                                                                                  bottom: -(imageSize.height + spacing),
                                                         right: 0)
                // raise the image and push it right so it appears centered
                //  above the text
                let titleSize: CGSize = titleLabel?.text?.size(withAttributes: [.font: titleLabel?.font ?? UIFont.systemFont(ofSize: 14)]) ?? CGSize.zero

                self.imageEdgeInsets = UIEdgeInsets.init(top: -spacing - titleSize.height,
                                                         left: 0,
                                                         bottom: 0,
                                                         right: 0 - titleSize.width)

                // increase the content height to avoid clipping
                let edgeOffset: CGFloat = abs(titleSize.height - imageSize.height) / 2
                self.contentEdgeInsets = UIEdgeInsets.init(top: edgeOffset,
                                                           left: 0,
                                                           bottom: edgeOffset,
                                                           right: 0)
            }
            else {
                self.contentEdgeInsets = UIEdgeInsets.init(top: 0,
                                                           left: 0,
                                                           bottom: 0,
                                                           right: 0)
            }
        }
        get {
            return self.isTitleUnderImage
        }
    }

    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }

    /// SwifterSwift: Set image for all states.
    ///
    /// - Parameter image: UIImage.
    func setImageForAllStates(_ image: UIImage) {
        states.forEach { setImage(image, for: $0) }
    }

    /// SwifterSwift: Set title color for all states.
    ///
    /// - Parameter color: UIColor.
    func setTitleColorForAllStates(_ color: UIColor) {
        states.forEach { setTitleColor(color, for: $0) }
    }

    /// SwifterSwift: Set title for all states.
    ///
    /// - Parameter title: title string.
    func setTitleForAllStates(_ title: String) {
        states.forEach { setTitle(title, for: $0) }
    }
}
