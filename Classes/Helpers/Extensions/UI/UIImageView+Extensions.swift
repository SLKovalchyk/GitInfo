//
//  UIImageView+Extensions.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setPathImage(path: String?,
                      placeholder: UIImage?,
                      processor: ImageProcessor? = nil) {
        image = placeholder
        guard let path = path else { return }
        guard let url = URL.init(string: path) else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url,
                         placeholder: placeholder,
                         options: [
                            .processor(processor ?? DownsamplingImageProcessor(size: bounds.size)),
                            .scaleFactor(UIScreen.main.scale),
                            .transition(.fade(0.2)),
                         ],
                         progressBlock: nil) { (result) in
            switch result {
            case .success(let value):
                self.image = value.image
                break
            case .failure(_):
                self.image = placeholder
                break
            }
        }
    }
    
}
