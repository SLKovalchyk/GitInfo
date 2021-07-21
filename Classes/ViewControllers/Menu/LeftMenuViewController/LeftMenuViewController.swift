//
//  LeftMenuViewController.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import UIKit

import SVProgressHUD
import FirebaseAuth

final class LeftMenuViewController: BaseViewController {
    
    @IBOutlet private weak var forkButton: UIButton!
    @IBOutlet private weak var starsButton: UIButton!
    @IBOutlet private weak var viewButton: UIButton!
    @IBOutlet private weak var actionButton: MyButton!
    @IBOutlet private weak var userInfoView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    
    private var provider: OAuthProvider?
    
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
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserWorker.shared.currentUser = nil
            self.configureView()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    private func goLoginProcess() {
        SVProgressHUD.show()
        provider = OAuthProvider(providerID: "github.com")
        provider?.scopes = ["user:email",
                            "read:user"]
        provider?.customParameters = [
            "allow_signup": "false"
        ]
        provider?.getCredentialWith(nil) { credential, error in
            if error != nil {
                SVProgressHUD.dismiss()
                self.showToastError(message: error?.localizedDescription ?? "Error")
                return
            }
            if let cred = credential {
                let auth = Auth.auth()
                auth.signIn(with: cred) { authResult, error in
                    if error != nil {
                        SVProgressHUD.dismiss()
                    }
                    
                    guard let oauthCredential = authResult?.credential as? OAuthCredential else { return }
                    let accessToken = oauthCredential.accessToken ?? ""
                    UserWorker.shared.sessionToken = accessToken
                    UserWorker.shared.getUserInfo { result, userError in
                        SVProgressHUD.dismiss()
                        if let error = userError {
                            self.showToastError(message: error.localizedDescription)
                        } else if let user = result {
                            UserWorker.shared.currentUser = user
                            self.configureView()
                        }
                    }
                }
            }
        }
    }
}
