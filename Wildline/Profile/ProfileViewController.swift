//
//  ProfileViewController.swift
//  WA8_4
//
//  Created by Max Grotstein on 11/6/25.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileView: ProfileView!
    
    override func loadView(){
        profileView = ProfileView()
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.95, alpha: 1.0)
        
        profileView.logoutButton.addTarget(self, action: #selector(onLogOutButtonTapped), for: .touchUpInside)
    }

    @objc func onLogOutButtonTapped(){
        let logoutAlert = UIAlertController(
            title: "Logging out!",
            message: "Are you sure you want to log out?",
            preferredStyle: .actionSheet
        )
        
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .destructive, handler: {(_) in
            UserToken.shared.logout()
            self.navigationController?.popViewController(animated: true)
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
}
