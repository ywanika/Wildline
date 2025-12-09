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
    var buttonRehaber: UIButton!
    var registerButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.95, alpha: 1.0)
        
        setupWelcomeLabel()
        setupCreateYourAccountLabel()
        setupFirstNameField()
        setupLastNameField()
        setupEmailField()
        setupPasswordField()
        setUpPhoneNumberField()
        setupButtonRehaber()
        setupRegisterButton()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        firstNameField = createStyledTextField(placeholder: "First Name")
        self.addSubview(firstNameField)
    }
    
    func setupLastNameField() {
        lastNameField = createStyledTextField(placeholder: "Last Name")
        self.addSubview(lastNameField)
    }
   
    func setupEmailField() {
        emailField = createStyledTextField(placeholder: "Email address")
        self.addSubview(emailField)
    }
    
    func setupPasswordField() {
        passwordField = createStyledTextField(placeholder: "Password")
        self.addSubview(passwordField)
    }
    
    func setUpPhoneNumberField() {
        phoneNumberField = createStyledTextField(placeholder: "Phone Number")
        self.addSubview(phoneNumberField)
    }
    
    func setupButtonRehaber() {
        buttonRehaber = createStyledSecondaryButton(title: "Register as Rehaber")
        self.addSubview(buttonRehaber)
    }
    
    func setupRegisterButton() {
        registerButton = createStyledPrimaryButton(title: "Register as User")
        self.addSubview(registerButton)
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
            
            registerButton.topAnchor.constraint(equalTo: phoneNumberField.bottomAnchor, constant: 30),
            registerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            buttonRehaber.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 16),
            buttonRehaber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonRehaber.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
    
}
