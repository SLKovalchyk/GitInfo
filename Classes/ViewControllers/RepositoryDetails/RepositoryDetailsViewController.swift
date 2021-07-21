//
//  RepositoryDetailsViewController.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 20.07.2021.
//

import UIKit

final class RepositoryDetailsViewController: BaseViewController, UINavigationControllerDelegate {

    @IBOutlet private weak var createdAtLabel: UILabel!
    @IBOutlet private weak var repoDescriptionLabel: UILabel!
    @IBOutlet private weak var updateAtLabel: UILabel!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var watchButton: UIButton!
    @IBOutlet private weak var starsButton: UIButton!
    @IBOutlet private weak var forkButton: UIButton!
    @IBOutlet private weak var ownerAvatarImageView: UIImageView!
    
    private var repository: Repository
    
    required init(repository: Repository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setTitle(title: repository.name)
        navigationItem.setLeftButtonType(type: .Back, target: self)
        let tap = UITapGestureRecognizer(target: self, action: #selector(openOwnerInfo))
        ownerAvatarImageView.addGestureRecognizer(tap)
        fillRepositoryData()
    }
    
    private func fillRepositoryData() {
        
        if let createdAt = repository.createdAt?.string() {
            createdAtLabel.text = (createdAtLabel.text ?? "") + " " + createdAt
        } else {
            createdAtLabel.isHidden = true
        }
        if let updateAt = repository.updateAt?.string() {
            updateAtLabel.text = (updateAtLabel.text ?? "") + " " + updateAt
        } else {
            updateAtLabel.isHidden = true
        }

        if let description = repository.description {
            repoDescriptionLabel.text = (repoDescriptionLabel.text ?? "") + " " + description
        } else {
            repoDescriptionLabel.isHidden = true
        }
        
        if let ownerName = repository.owner?.name {
            authorNameLabel.text = ownerName
        } else {
            authorNameLabel.isHidden = true
        }
        
        ownerAvatarImageView.setPathImage(path: repository.owner?.avatarPath,
                                          placeholder: #imageLiteral(resourceName: "git"))
        watchButton.setTitle("\(repository.watchers)", for: .normal)
        starsButton.setTitle("\(repository.stars)", for: .normal)
        forkButton.setTitle("\(repository.fork)", for: .normal)
    }
    
    // MARK: - User action methods -
    @IBAction func viewFullInfoPressed(_ sender: UIButton) {
        guard let infoPath = repository.infoPath,
              let url = URL(string: infoPath) else { return }
        UIApplication.shared.open(url,
                                  options: [:],
                                  completionHandler: nil)
    }
    
    @objc func openOwnerInfo() {
        guard let owner = repository.owner else { return }
        let vc = UserInfoViewController(user: owner)
        present(vc, animated: true, completion: nil)
    }
}
