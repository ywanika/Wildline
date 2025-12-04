//
//  LoginView.swift
//  Final Project
//
//  Created by Student on 11/16/25.
//

import UIKit

class LoginView: UIView {
    var loginLabel: UILabel!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonLogin: UIButton!
    var buttonRegister: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.95, alpha: 1.0)
        
        setupLoginLabel()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupButtonLogin()
        setupButtonRegister()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLoginLabel() {
        loginLabel = UILabel()
        loginLabel.text = "Login"
        loginLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        loginLabel.textColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0) // Forest green
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginLabel)
    }
    
    func setupTextFieldEmail() {
        textFieldEmail = createStyledTextField(placeholder: "Email")
        self.addSubview(textFieldEmail)
    }
    
    func setupTextFieldPassword() {
        textFieldPassword = createStyledTextField(placeholder: "Password")
        textFieldPassword.isSecureTextEntry = true
        self.addSubview(textFieldPassword)
    }
    
    func setupButtonLogin() {
        buttonLogin = createStyledPrimaryButton(title: "Log In")
        self.addSubview(buttonLogin)
    }
    
    func setupButtonRegister() {
        buttonRegister = UIButton(type: .system)
        buttonRegister.setTitle("Don't have an account? Create One Here!", for: .normal)
        buttonRegister.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        buttonRegister.setTitleColor(UIColor(red: 0.25, green: 0.55, blue: 0.35, alpha: 1.0), for: .normal)
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonRegister)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 120),
            loginLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            textFieldEmail.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 84),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 50),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            textFieldPassword.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),
            
            buttonLogin.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 32),
            buttonLogin.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonLogin.widthAnchor.constraint(equalTo: textFieldEmail.widthAnchor),
            buttonLogin.heightAnchor.constraint(equalToConstant: 50),
            
            buttonRegister.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 8),
            buttonRegister.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
}
