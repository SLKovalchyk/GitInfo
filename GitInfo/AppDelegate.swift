//
//  AppDelegate.swift
//  GitInfo
//
//  Created by Sergey Kovalchyk on 19.07.2021.
//

import UIKit
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureLibs()
        configureViews()
        
        let worker = InitialScreenWorker()
        window = worker.createWindow()
    
        return true
    }

    func configureLibs() {
        // disable-enable user action when spiner isON
        NotificationCenter.default.addObserver(self, selector: #selector(requestWillStart),
                                               name: NSNotification.Name.SVProgressHUDWillAppear,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(requestDidFinish),
                                               name: NSNotification.Name.SVProgressHUDDidDisappear,
                                               object: nil)
    }

    func configureViews() {
        //Navigation bar
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.black,
                                                            .font : UIFont.systemFont(ofSize: 20, weight: .light)]
    }
    
    @objc func requestWillStart() {
        (UIApplication.shared.delegate as! AppDelegate).window?.endEditing(true)
        (UIApplication.shared.delegate as! AppDelegate).window?.isUserInteractionEnabled = false
    }

    @objc func requestDidFinish() {
        (UIApplication.shared.delegate as! AppDelegate).window?.isUserInteractionEnabled = true
    }


}

