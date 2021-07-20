//
//  CellInterface.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import UIKit

protocol CellInterface: AnyObject {
    static var id: String { get }
    static var cellNib: UINib { get }
    static func loadFromNib() -> UIView?
}

extension CellInterface {
    
    static var id: String {
        return String(describing: self).components(separatedBy: "<").first ?? ""
    }
    
    static var cellNib: UINib {
        return UINib(nibName: id, bundle: Bundle.main)
    }

    static func loadFromNib() -> UIView? {
        return cellNib.instantiate(withOwner: nil, options: nil).first as? UIView
    }
}
