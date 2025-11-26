//
//  LogInView.swift
//  Wildline
//
//  Created by Max Grotstein on 11/13/25.
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
        textFieldEmail = UITextField()
        textFieldEmail.borderStyle = .none
        textFieldEmail.placeholder = "Email"
        textFieldEmail.autocapitalizationType = .none
        textFieldEmail.font = UIFont.systemFont(ofSize: 16)
        textFieldEmail.backgroundColor = .white
        textFieldEmail.layer.cornerRadius = 12
        textFieldEmail.layer.borderWidth = 1.5
        textFieldEmail.layer.borderColor = UIColor(red: 0.5, green: 0.75, blue: 0.5, alpha: 1.0).cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textFieldEmail.frame.height))
        textFieldEmail.leftView = paddingView
        textFieldEmail.leftViewMode = .always
        
        textFieldEmail.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.1).cgColor
        textFieldEmail.layer.shadowOffset = CGSize(width: 0, height: 2)
        textFieldEmail.layer.shadowRadius = 4
        textFieldEmail.layer.shadowOpacity = 1.0
        
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setupTextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.borderStyle = .none
        textFieldPassword.autocapitalizationType = .none
        textFieldPassword.placeholder = "Password"
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.font = UIFont.systemFont(ofSize: 16)
        textFieldPassword.backgroundColor = .white
        textFieldPassword.layer.cornerRadius = 12
        textFieldPassword.layer.borderWidth = 1.5
        textFieldPassword.layer.borderColor = UIColor(red: 0.5, green: 0.75, blue: 0.5, alpha: 1.0).cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textFieldPassword.frame.height))
        textFieldPassword.leftView = paddingView
        textFieldPassword.leftViewMode = .always
        
        textFieldPassword.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.1).cgColor
        textFieldPassword.layer.shadowOffset = CGSize(width: 0, height: 2)
        textFieldPassword.layer.shadowRadius = 4
        textFieldPassword.layer.shadowOpacity = 1.0
        
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setupButtonLogin() {
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        buttonLogin.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0) // Vibrant green
        buttonLogin.setTitleColor(.white, for: .normal)
        buttonLogin.layer.cornerRadius = 12
        
        buttonLogin.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.3).cgColor
        buttonLogin.layer.shadowOffset = CGSize(width: 0, height: 4)
        buttonLogin.layer.shadowRadius = 6
        buttonLogin.layer.shadowOpacity = 1.0
        
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogin)
    }
    
    func setupButtonRegister() {
        buttonRegister = UIButton(type: .system)
        buttonRegister.setTitle("Create Account", for: .normal)
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
