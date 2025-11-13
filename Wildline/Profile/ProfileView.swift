//
//  ProfileView.swift
//  Wildline
//
//  Created by Max Grotstein on 11/13/25.
//

import UIKit

class ProfileView: UIView {
    
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var logoutButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupProfileImageView()
        setupNameLabel()
        setupEmailLabel()
        setupLogoutButton()
        
        initConstraints()
    }
    
    func setupProfileImageView() {
        profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.crop.circle")
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 10
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileImageView)
    }
    
    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = .preferredFont(forTextStyle: .title2)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
    }
    
    func setupEmailLabel() {
        emailLabel = UILabel()
        emailLabel.textColor = .secondaryLabel
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailLabel)
    }
    
    func setupLogoutButton() {
        logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoutButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            profileImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            logoutButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 24),
            logoutButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
