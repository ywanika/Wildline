//
//  RegisterViewController.swift
//  Final Project
//
//  Created by Student on 11/16/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    var registerView = RegisterView()
    var selectedType: String = ""
    let childProgressView = ProgressSpinnerViewController()
    var database = Firestore.firestore()
    
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Register"
        
        registerView.buttonRehaber.menu = getMenuTypes()
        registerView.registerButton.addTarget(self, action: #selector(onRegisteredButtonTap), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    @objc func onSelectTypeButtonTapped() {
        
    }
    
    @objc func onRegisteredButtonTap() {
        let email = registerView.emailField.text
        let firstName = registerView.firstNameField.text
        let lastName = registerView.lastNameField.text
        let password = registerView.passwordField.text
        let phoneNumber = registerView.phoneNumberField.text
        
        //TODO add in validation
        
        if let unwrappedEmail = email, let unwrappedPassword = password, let unwrappedPhoneNumber = phoneNumber {
            if !unwrappedEmail.isEmpty && !unwrappedPassword.isEmpty && !unwrappedPhoneNumber.isEmpty{
                if validateEmail(unwrappedEmail) && validatePassword(unwrappedPassword) && validatePhoneNumber(unwrappedPhoneNumber){
                    
                    Task {
                        do {
                            let exists = try await existsInDatabase(email: email!)
                            if exists {
                                showErrorAlert(message: "Email already exists.")
                            }
                        } catch {
                            print("Error checking if email exists: \(error)")
                        }
                    }
                    
                    let user = User(email: email!, name: "\(firstName ?? "") \(lastName ?? "")", phoneNumber: unwrappedPhoneNumber, role: Roles(rawValue: "user") ?? Roles.User)
                    registerNewAccount(user: user)
                    
                    loginSuccessful(userId: unwrappedEmail, userRole: unwrappedPassword)

                }
            }
        }
    }
        
    func existsInDatabase(email: String) async throws -> Bool {
        let db = Firestore.firestore()
        
        let query = db.collection("users").whereField("email", isEqualTo: email)
        
        let snapshot = try await query.getDocuments()
        return !snapshot.documents.isEmpty
    }

    func getMenuTypes() -> UIMenu {
        var menuItems = [UIAction]()
        let userTypes = ["user", "admin"]
                
        for type in userTypes {
            let menuItem = UIAction(title: type,handler: {(_) in
                                self.selectedType = type
                                self.registerView.buttonRehaber.setTitle(self.selectedType, for: .normal)
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
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email){
            return true
        } else{
            showErrorAlert(message: "Invalid Email!")
            return false
        }
    }
    
    func validatePhoneNumber(_ phoneNum: String) -> Bool {
        guard phoneNum.count == 10, let _ = Int(phoneNum) else {
            showErrorAlert(message: "Invalid Phone Number!")
            return false
        }
        return true
    }
    
    func validatePassword(_ password: String) -> Bool {
        guard password.count >= 8, let _ = Int(password) else {
            showErrorAlert(message: "Password must be at least 8 characters")
            return false
        }
        return true
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
