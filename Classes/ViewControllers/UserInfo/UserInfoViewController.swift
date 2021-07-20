//
//  UserInfoViewController.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 20.07.2021.
//

import UIKit

final class UserInfoViewController: BaseViewController {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var fullNameLabel: UILabel!
    
    var user: Owner
    
    required init(user: Owner) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setLeftButtonType(type: .Back, target: self)
        avatarImageView.setPathImage(path: user.avatarPath,
                                     placeholder: #imageLiteral(resourceName: "git"))
        nameLabel.text = user.name
        fullNameLabel.text = user.fullName
    }
    
    @IBAction private func viewFullInfoPressed(_ sender: UIButton) {
        guard let infoPath = user.infoPath,
              let url = URL(string: infoPath) else { return }
        UIApplication.shared.open(url,
                                  options: [:],
                                  completionHandler: nil)
    }
}
