//
//  BaseTableViewCell.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import UIKit

class BaseTableViewCell: UITableViewCell, CellInterface {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let bgColorView = UIView()
        bgColorView.backgroundColor = .clear
        selectedBackgroundView = bgColorView
    }
}
