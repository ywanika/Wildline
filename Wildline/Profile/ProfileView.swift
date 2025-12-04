//
//  ProfileView.swift
//  Wildline
//
//  Created by Max Grotstein on 11/13/25.
//

import UIKit

class ProfileView: UIView {
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var profileImageButton: UIButton!
    
    var personalInfoLabel: UILabel!
    var firstNameField: UITextField!
    var lastNameField: UITextField!
    var emailField: UITextField!
    var phoneField: UITextField!
    
    var settingsLabel: UILabel!
    var changePasswordButton: UIButton!
    var notificationsSwitch: UISwitch!
    var notificationsLabel: UILabel!
    var locationSwitch: UISwitch!
    var locationLabel: UILabel!
    
    var logoutButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.95, alpha: 1.0)
        
        setupScrollView()
        setupContentView()
        setupProfileImage()
        setupPersonalInfo()
        setupSettings()
        setupLogoutButton()
        
        initConstraints()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
    func setupContentView() {
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    
    func setupProfileImage() {
        profileImageButton = UIButton(type: .custom)
        profileImageButton.setImage(UIImage(systemName: "person.crop.circle.fill"), for: .normal)
        profileImageButton.tintColor = UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0)
        profileImageButton.contentMode = .scaleAspectFill
        profileImageButton.clipsToBounds = true
        profileImageButton.layer.cornerRadius = 80
        profileImageButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(profileImageButton)
    }
    
    func setupPersonalInfo() {
        personalInfoLabel = UILabel()
        personalInfoLabel.text = "Personal Information"
        personalInfoLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        personalInfoLabel.textColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        personalInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(personalInfoLabel)
        
        firstNameField = createStyledTextField(placeholder: "First Name")
        contentView.addSubview(firstNameField)
        
        lastNameField = createStyledTextField(placeholder: "Last Name")
        contentView.addSubview(lastNameField)
        
        emailField = createStyledTextField(placeholder: "Email (example@email.com)")
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        contentView.addSubview(emailField)
        
        phoneField = createStyledTextField(placeholder: "Phone (+1 (XXX) XXX-XXXX)")
        phoneField.keyboardType = .phonePad
        contentView.addSubview(phoneField)
    }
    
    func setupSettings() {
        settingsLabel = UILabel()
        settingsLabel.text = "Settings"
        settingsLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        settingsLabel.textColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(settingsLabel)
        
        changePasswordButton = UIButton(type: .system)
        changePasswordButton.setTitle("Change Password", for: .normal)
        changePasswordButton.setTitleColor(.white, for: .normal)
        changePasswordButton.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0)
        changePasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        changePasswordButton.layer.cornerRadius = 12
        changePasswordButton.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.3).cgColor
        changePasswordButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        changePasswordButton.layer.shadowRadius = 6
        changePasswordButton.layer.shadowOpacity = 1.0
        changePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(changePasswordButton)
        
        let notificationsContainer = createSettingRow()
        contentView.addSubview(notificationsContainer)
        
        notificationsLabel = UILabel()
        notificationsLabel.text = "Push Notifications"
        notificationsLabel.font = UIFont.systemFont(ofSize: 16)
        notificationsLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationsContainer.addSubview(notificationsLabel)
        
        notificationsSwitch = UISwitch()
        notificationsSwitch.onTintColor = UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0)
        notificationsSwitch.translatesAutoresizingMaskIntoConstraints = false
        notificationsContainer.addSubview(notificationsSwitch)
        
        NSLayoutConstraint.activate([
            notificationsContainer.topAnchor.constraint(equalTo: changePasswordButton.bottomAnchor, constant: 16),
            notificationsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            notificationsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            notificationsContainer.heightAnchor.constraint(equalToConstant: 50),
            
            notificationsLabel.centerYAnchor.constraint(equalTo: notificationsContainer.centerYAnchor),
            notificationsLabel.leadingAnchor.constraint(equalTo: notificationsContainer.leadingAnchor, constant: 16),
            
            notificationsSwitch.centerYAnchor.constraint(equalTo: notificationsContainer.centerYAnchor),
            notificationsSwitch.trailingAnchor.constraint(equalTo: notificationsContainer.trailingAnchor, constant: -16)
        ])
        
        let locationContainer = createSettingRow()
        contentView.addSubview(locationContainer)
        
        locationLabel = UILabel()
        locationLabel.text = "Location Services"
        locationLabel.font = UIFont.systemFont(ofSize: 16)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationContainer.addSubview(locationLabel)
        
        locationSwitch = UISwitch()
        locationSwitch.onTintColor = UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0)
        locationSwitch.translatesAutoresizingMaskIntoConstraints = false
        locationContainer.addSubview(locationSwitch)
        
        NSLayoutConstraint.activate([
            locationContainer.topAnchor.constraint(equalTo: notificationsContainer.bottomAnchor, constant: 12),
            locationContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            locationContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            locationContainer.heightAnchor.constraint(equalToConstant: 50),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationContainer.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationContainer.leadingAnchor, constant: 16),
            
            locationSwitch.centerYAnchor.constraint(equalTo: locationContainer.centerYAnchor),
            locationSwitch.trailingAnchor.constraint(equalTo: locationContainer.trailingAnchor, constant: -16)
        ])
    }
    
    func setupLogoutButton() {
        logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.setTitleColor(.systemRed, for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        logoutButton.backgroundColor = .white
        logoutButton.layer.cornerRadius = 12
        logoutButton.layer.borderWidth = 2
        logoutButton.layer.borderColor = UIColor.systemRed.cgColor
        logoutButton.layer.shadowColor = UIColor.systemRed.withAlphaComponent(0.2).cgColor
        logoutButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        logoutButton.layer.shadowRadius = 6
        logoutButton.layer.shadowOpacity = 1.0
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(logoutButton)
    }
    
    func createSettingRow() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.1).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            profileImageButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImageButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageButton.widthAnchor.constraint(equalToConstant: 160),
            profileImageButton.heightAnchor.constraint(equalToConstant: 160),
            
            personalInfoLabel.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: 32),
            personalInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            firstNameField.topAnchor.constraint(equalTo: personalInfoLabel.bottomAnchor, constant: 16),
            firstNameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            firstNameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            firstNameField.heightAnchor.constraint(equalToConstant: 50),
            
            lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 12),
            lastNameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            lastNameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            lastNameField.heightAnchor.constraint(equalToConstant: 50),
            
            emailField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 12),
            emailField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            
            phoneField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12),
            phoneField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            phoneField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            phoneField.heightAnchor.constraint(equalToConstant: 50),
            
            settingsLabel.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 32),
            settingsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            changePasswordButton.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 16),
            changePasswordButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            changePasswordButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 50),
            
            logoutButton.topAnchor.constraint(equalTo: changePasswordButton.bottomAnchor, constant: 80),
            logoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
