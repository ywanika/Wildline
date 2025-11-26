//
//  RegisterViewController.swift
//  Final Project
//
//  Created by Student on 11/16/25.
//

import UIKit

class RegisterViewController: UIViewController {

    var registerView = RegisterView()
    var selectedType: String = ""
    
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Register"
        
        registerView.buttonSelectType.menu = getMenuTypes()
        registerView.registerButton.addTarget(self, action: #selector(onRegisteredButtonTap), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    @objc func onSelectTypeButtonTapped() {
        
    }
    
    @objc func onRegisteredButtonTap() {
        let email = registerView.emailField.text
        let password = registerView.passwordField.text
        
        //TODO add in validation
        
        if let unwrappedEmail = email, let unwrappedPassword = password {
            if !unwrappedEmail.isEmpty && !unwrappedPassword.isEmpty{
                if unwrappedPassword != "admin" && unwrappedPassword != "user"{
//                    showErrorAlert(message: "Make password either 'admin' or 'user'")
                }
                
                loginSuccessful(userId: unwrappedEmail, userRole: unwrappedPassword)
                
            }
        }
    }

    func getMenuTypes() -> UIMenu {
        var menuItems = [UIAction]()
        let userTypes = ["user", "admin"]
                
        for type in userTypes {
            let menuItem = UIAction(title: type,handler: {(_) in
                                self.selectedType = type
                                self.registerView.buttonSelectType.setTitle(self.selectedType, for: .normal)
                            })
            menuItems.append(menuItem)
        }
        
        return UIMenu(title: "Select type", children: menuItems)
    }
    
    func loginSuccessful(userId: String, userRole: String) {
        UserToken.shared.saveUserId(userId)
        UserToken.shared.saveUserRole(userRole)
        
        // Dismiss the navigation controller (not just self)
        navigationController?.dismiss(animated: true, completion: nil)
    }

}
