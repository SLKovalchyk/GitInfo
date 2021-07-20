//
//  MyButton.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import UIKit

class MyButton: UIButton {
    enum Style: Int {
        case defaultStyle = 0
        case borderStyle = 1
        
        var styleParams: StyleParams {
            get {
                switch self {
                case .defaultStyle:
                    return StyleParams(titleColor: .white,
                                       backgroundColor: .blue)
                case .borderStyle:
                    return StyleParams(titleColor: .blue,
                                       backgroundColor: .white)
                }
            }
        }
    }
    
    struct StyleParams {
        var titleColor: UIColor
        var backgroundColor: UIColor
    }
    
    @IBInspectable var styleAdapter: Int {
        get {
            return self.style.rawValue
        }
        set (newValue) {
            self.style = Style(rawValue: newValue) ?? .defaultStyle
        }
    }
    
    var style: Style = .defaultStyle {
        didSet {
            self.configure()
        }
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = rect.height / 2
        layer.masksToBounds = true
    }
    
    private func configure() {
        backgroundColor = style.styleParams.backgroundColor
        setTitleColor(style.styleParams.titleColor, for: .normal)
        if style == .borderStyle {
            layer.borderWidth = 1
            layer.borderColor = style.styleParams.titleColor.cgColor
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = self.isEnabled ?
                    self.style.styleParams.backgroundColor:
                    self.style.styleParams.backgroundColor.withAlphaComponent(0.5)
                
                self.setTitleColorForAllStates(self.isEnabled ?
                                                self.style.styleParams.titleColor:
                                                self.style.styleParams.titleColor.withAlphaComponent(0.5))
                
                if self.style == .borderStyle {
                    self.layer.borderColor = self.isEnabled ?
                        self.style.styleParams.titleColor.cgColor:
                        self.style.styleParams.titleColor.withAlphaComponent(0.5).cgColor
                }
            }
        }
    }
    
}
