//
//  RegisterView.swift
//  Final Project
//
//  Created by Student on 11/16/25.
//

import UIKit

class RegisterView: UIView {

    var welcomeLabel: UILabel!
    var createYourAccountLabel: UILabel!
    var firstNameField: UITextField!
    var lastNameField: UITextField!
    var emailField: UITextField!
    var passwordField: UITextField!
    var phoneNumberField: UITextField!
    var typeLabel: UILabel!
    var buttonSelectType: UIButton!
    var registerButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupWelcomeLabel()
        setupCreateYourAccountLabel()
        setupFirstNameField()
        setupLastNameField()
        setupEmailField()
        setupPasswordField()
        setUpPhoneNumberField()
        setupTypeLabel()
        setupButtonSelectType()
        setupRegisterButton()
        
        initConstraints()
    }
    
    func setupWelcomeLabel() {
        welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome!"
        welcomeLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(welcomeLabel)
    }
    
    func setupCreateYourAccountLabel() {
        createYourAccountLabel = UILabel()
        createYourAccountLabel.text = "Create Your Account"
        createYourAccountLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        createYourAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(createYourAccountLabel)
    }
    
    func setupFirstNameField() {
        firstNameField = UITextField()
        firstNameField.placeholder = "First Name"
        firstNameField.borderStyle = .roundedRect
        firstNameField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(firstNameField)
    }
    
    func setupLastNameField() {
        lastNameField = UITextField()
        lastNameField.placeholder = "Last Name"
        lastNameField.borderStyle = .roundedRect
        lastNameField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lastNameField)
    }
   
    func setupEmailField() {
        emailField = UITextField()
        emailField.placeholder = "Email address"
        emailField.borderStyle = .roundedRect
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        emailField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailField)
    }
    
    func setupPasswordField() {
        passwordField = UITextField()
        passwordField.placeholder = "Password"
        passwordField.borderStyle = .roundedRect
        passwordField.autocapitalizationType = .none
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordField)
    }
    
    func setUpPhoneNumberField() {
        phoneNumberField = UITextField()
        phoneNumberField.placeholder = "Phone number"
        phoneNumberField.borderStyle = .roundedRect
        phoneNumberField.keyboardType = .numberPad
        phoneNumberField.autocapitalizationType = .none
        phoneNumberField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneNumberField)
    }
    
    func setupTypeLabel() {
        typeLabel = UILabel()
        typeLabel.text = "How will you use our app?"
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(typeLabel)
    }
    
    func setupButtonSelectType() {
        buttonSelectType = UIButton(type: .system)
        buttonSelectType.setTitle("Select type", for: .normal)
        buttonSelectType.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSelectType)
    }
    
    func setupRegisterButton() {
        registerButton = UIButton(type: .system)
        registerButton.setTitle("Register", for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            createYourAccountLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8),
            createYourAccountLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            firstNameField.topAnchor.constraint(equalTo: createYourAccountLabel.bottomAnchor, constant: 24),
            firstNameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            firstNameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 16),
            lastNameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            lastNameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            emailField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 16),
            emailField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16),
            passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            phoneNumberField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            phoneNumberField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            phoneNumberField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            typeLabel.topAnchor.constraint(equalTo: phoneNumberField.bottomAnchor, constant: 20),
            typeLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            buttonSelectType.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 16),
            buttonSelectType.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonSelectType.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            registerButton.topAnchor.constraint(equalTo: buttonSelectType.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
    
}
