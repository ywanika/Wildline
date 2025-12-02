//
//  RehabberProfileView.swift
//  Wildline
//
//  Created by Max Grotstein on 11/13/25.
//

import UIKit

class RehabberProfileView: ProfileView {
    
    var rehabberInfoLabel: UILabel!
    var facilityNameField: UITextField!
    var licenseNumberField: UITextField!
    var experienceField: UITextField!
    var specializationsField: UITextField!
    var serviceRadiusField: UITextField!
    
    var certificationsLabel: UILabel!
    var certificationsCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupRehabberInfo()
        setupCertifications()
        
        initConstraints()
    }
    
    func setupRehabberInfo() {
        rehabberInfoLabel = UILabel()
        rehabberInfoLabel.text = "Rehabber Information"
        rehabberInfoLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        rehabberInfoLabel.textColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        rehabberInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(rehabberInfoLabel)
        
        facilityNameField = createStyledTextField(placeholder: "Facility/Organization Name")
        contentView.addSubview(facilityNameField)
        
        licenseNumberField = createStyledTextField(placeholder: "License Number")
        contentView.addSubview(licenseNumberField)
        
        experienceField = createStyledTextField(placeholder: "Years of Experience")
        experienceField.keyboardType = .numberPad
        contentView.addSubview(experienceField)
        
        specializationsField = createStyledTextField(placeholder: "Specializations (e.g., Birds, Mammals)")
        contentView.addSubview(specializationsField)
        
        serviceRadiusField = createStyledTextField(placeholder: "Service Radius (miles)")
        serviceRadiusField.keyboardType = .numberPad
        contentView.addSubview(serviceRadiusField)
    }
    
    func setupCertifications() {
        certificationsLabel = UILabel()
        certificationsLabel.text = "Certifications"
        certificationsLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        certificationsLabel.textColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        certificationsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(certificationsLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.minimumLineSpacing = 12
        
        certificationsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        certificationsCollectionView.backgroundColor = .clear
        certificationsCollectionView.showsHorizontalScrollIndicator = false
        certificationsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(certificationsCollectionView)
    }
    
    override func initConstraints() {
        super.initConstraints()
        
        logoutButton.removeFromSuperview()
        settingsLabel.removeFromSuperview()
        changePasswordButton.removeFromSuperview()
        
        NSLayoutConstraint.activate([
            rehabberInfoLabel.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 32),
            rehabberInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            facilityNameField.topAnchor.constraint(equalTo: rehabberInfoLabel.bottomAnchor, constant: 16),
            facilityNameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            facilityNameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            facilityNameField.heightAnchor.constraint(equalToConstant: 50),
            
            licenseNumberField.topAnchor.constraint(equalTo: facilityNameField.bottomAnchor, constant: 12),
            licenseNumberField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            licenseNumberField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            licenseNumberField.heightAnchor.constraint(equalToConstant: 50),
            
            experienceField.topAnchor.constraint(equalTo: licenseNumberField.bottomAnchor, constant: 12),
            experienceField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            experienceField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            experienceField.heightAnchor.constraint(equalToConstant: 50),
            
            specializationsField.topAnchor.constraint(equalTo: experienceField.bottomAnchor, constant: 12),
            specializationsField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            specializationsField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            specializationsField.heightAnchor.constraint(equalToConstant: 50),
            
            serviceRadiusField.topAnchor.constraint(equalTo: specializationsField.bottomAnchor, constant: 12),
            serviceRadiusField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            serviceRadiusField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            serviceRadiusField.heightAnchor.constraint(equalToConstant: 50),
            
            certificationsLabel.topAnchor.constraint(equalTo: serviceRadiusField.bottomAnchor, constant: 32),
            certificationsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            certificationsCollectionView.topAnchor.constraint(equalTo: certificationsLabel.bottomAnchor, constant: 16),
            certificationsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            certificationsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            certificationsCollectionView.heightAnchor.constraint(equalToConstant: 120),
        ])
        
        contentView.addSubview(settingsLabel)
        contentView.addSubview(changePasswordButton)
        contentView.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            settingsLabel.topAnchor.constraint(equalTo: certificationsCollectionView.bottomAnchor, constant: 32),
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
