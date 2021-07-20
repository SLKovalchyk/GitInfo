//
//  BaseView.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 20.07.2021.
//

import UIKit

class BaseView: UIView {

    @IBOutlet var contentView: UIView!
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let nib = String(describing: type(of: self))
        Bundle.main.loadNibNamed(nib, owner: self, options: nil)
        addSubview(contentView)
        contentView.fillToSuperview()
    }
}

extension UIView {
    func fillToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
}
