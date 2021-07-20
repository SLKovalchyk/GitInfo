//
//  LeftMenuViewController.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import UIKit

final class LeftMenuViewController: UIViewController {

    @IBOutlet private weak var actionButton: MyButton!
    @IBOutlet private weak var userInfoView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        if let currentUser = UserWorker.shared.currentUser {
            userInfoView.isHidden = false
            avatarImageView.setPathImage(path: currentUser.avatarPath,
                                         placeholder: #imageLiteral(resourceName: "github"))
            userNameLabel.text = currentUser.name
            actionButton.setTitle("Log out", for: .normal)
        } else {
            userInfoView.isHidden = true
            actionButton.setTitle("Log in", for: .normal)
        }
    }
    
    // MARK: - user action method -
    @IBAction func logInPressed(_ sender: Any) {
        if UserWorker.shared.currentUser != nil {
            goLogOutProcess()
        } else {
            goLoginProcess()
        }
    }
    
    private func goLogOutProcess() {
        
    }
    
    private func goLoginProcess() {
        
    }
}
