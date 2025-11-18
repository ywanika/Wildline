//
//  LoginViewController.swift
//  Final Project
//
//  Created by Student on 11/16/25.
//

import UIKit

class LoginViewController: UIViewController {
    var loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
        
        loginView.buttonLogin.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func onLoginButtonTapped(){
        
        let email = loginView.textFieldEmail.text
        let password = loginView.textFieldPassword.text
        
        //TODO
        
        if let unwrappedEmail = email, let unwrappedPassword = password {
            if !unwrappedEmail.isEmpty && !unwrappedPassword.isEmpty{
                if unwrappedPassword != "admin" || unwrappedPassword != "user"{
                    showErrorAlert(message: "Make password either 'admin' or 'user'")
                }
                UserToken.shared.saveUserId(unwrappedEmail)
                UserToken.shared.saveUserRole(unwrappedPassword)
            }
        }
        
    }
    
    func showErrorAlert(message:String = ""){
        let alert = UIAlertController(
            title: "Error!",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }

}
