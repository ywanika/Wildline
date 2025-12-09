//
//  LoginViewController.swift
//  Final Project
//
//  Created by Max Grotstein on 11/16/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    var loginView = LoginView()
    let childProgressView = ProgressSpinnerViewController()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
        
        loginView.buttonLogin.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        loginView.buttonRegister.addTarget(self, action: #selector(onRegisterButtonTapped), for: .touchUpInside)
    }
    
    @objc func onRegisterButtonTapped(){
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onLoginButtonTapped(){
        
        let email = loginView.textFieldEmail.text
        let password = loginView.textFieldPassword.text
        
        //TODO
        
        if let unwrappedEmail = email, let unwrappedPassword = password {
            if !unwrappedEmail.isEmpty && !unwrappedPassword.isEmpty{
                signInToFirebase(email: unwrappedEmail, password: unwrappedPassword)
            }
        }
        
    }
    
    func loginSuccessful(userId: String, userRole: String) {
        // UserToken.shared.saveUserId(userId)
        // UserToken.shared.saveUserRole(userRole)
        
        // Dismiss the navigation controller (not just self)
        navigationController?.dismiss(animated: true, completion: nil)
    }

}
