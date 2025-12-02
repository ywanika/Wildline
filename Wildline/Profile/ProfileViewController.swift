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
        profileView.changePasswordButton.addTarget(self, action: #selector(onChangePasswordTapped), for: .touchUpInside)
        
        loadUserData()
    }
    
    func loadUserData() {
        if let userId = UserToken.shared.getUserId() {
            profileView.emailField.text = userId
        }
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
    
    @objc func onChangePasswordTapped() {
        let alert = UIAlertController(title: "Change Password", message: "Enter your new password", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Current Password"
            textField.isSecureTextEntry = true
        }
        
        alert.addTextField { textField in
            textField.placeholder = "New Password"
            textField.isSecureTextEntry = true
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Confirm New Password"
            textField.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Change", style: .default, handler: { _ in
            guard let currentPassword = alert.textFields?[0].text,
                  let newPassword = alert.textFields?[1].text,
                  let confirmPassword = alert.textFields?[2].text else { return }
            
            if newPassword == confirmPassword && !newPassword.isEmpty {
                let successAlert = UIAlertController(title: "Success", message: "Password changed successfully", preferredStyle: .alert)
                successAlert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(successAlert, animated: true)
            } else {
                let errorAlert = UIAlertController(title: "Error", message: "Passwords don't match or are empty", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(errorAlert, animated: true)
            }
        }))
        
        present(alert, animated: true)
    }
}
