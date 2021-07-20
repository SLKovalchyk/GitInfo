//
//  HomeTableViewCell.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import UIKit

final class HomeTableViewCell: BaseTableViewCell {

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var logoImageView: UIImageView!
    
    @IBOutlet private weak var watchButton: UIButton!
    @IBOutlet private weak var starButton: UIButton!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var forkButton: UIButton!
    
    var avatarTapHandler: Completions.Empty?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if Configuration.current.isShowDetailEnable {
            logoImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(logoTapAction))
            logoImageView.addGestureRecognizer(tap)
        }
    }
    
    func configure(_ repository: Repository) {
        dateLabel.text = repository.updateAt?.string(withFormat: "dd MMMM YYYY")
        nameLabel.text = repository.name
        logoImageView.setPathImage(path: repository.owner?.avatarPath,
                                   placeholder: #imageLiteral(resourceName: "git"))
        authorNameLabel.text = repository.owner?.name
        watchButton.setTitle("\(repository.watchers)", for: .normal)
        starButton.setTitle("\(repository.stars)", for: .normal)
        forkButton.setTitle("\(repository.fork)", for: .normal)
    }
    
    @objc func logoTapAction() {
        avatarTapHandler?()
    }
}
