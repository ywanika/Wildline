//
//  ReportView.swift
//  Wildline
//
//  Created by Max Grotstein on 11/13/25.
//

import UIKit

class MakeReportView: UIView {

    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var titleLabel: UILabel!
    var titleField: UITextField!
    var descriptionLabel: UILabel!
    var descriptionTextView: UITextView!
    var locationLabel: UILabel!
    var addressField: UITextField!
    var mapButton: UIButton!
    var submitPhotoLabel: UILabel!
    var buttonSelectPhoto: UIButton!
    var sendReportButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.95, alpha: 1.0)
                
        setupScrollView()
        setupContentView()
        setupTitleLabel()
        setupTitleField()
        setupDescriptionLabel()
        setupDescriptionTextView()
        setupLocationLabel()
        setupAddressField()
        setupMapButton()
        setupSubmitPhotoLabel()
        setupButtonSelectPhoto()
        setupSendReportButton()
        
        initConstraints()
        
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
    func setupContentView() {
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
    }
    
    func setupTitleField() {
        titleField = UITextField()
        titleField.borderStyle = .none
        titleField.font = UIFont.systemFont(ofSize: 16)
        titleField.backgroundColor = .white
        titleField.layer.cornerRadius = 12
        titleField.layer.borderWidth = 1.5
        titleField.layer.borderColor = UIColor(red: 0.5, green: 0.75, blue: 0.5, alpha: 1.0).cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: titleField.frame.height))
        titleField.leftView = paddingView
        titleField.leftViewMode = .always
        
        titleField.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.1).cgColor
        titleField.layer.shadowOffset = CGSize(width: 0, height: 2)
        titleField.layer.shadowRadius = 4
        titleField.layer.shadowOpacity = 1.0
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleField)
    }
    
    func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        descriptionLabel.textColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
    }
    
    func setupDescriptionTextView() {
        descriptionTextView = UITextView()
        descriptionTextView.backgroundColor = .white
        descriptionTextView.layer.cornerRadius = 12
        descriptionTextView.layer.borderWidth = 1.5
        descriptionTextView.layer.borderColor = UIColor(red: 0.5, green: 0.75, blue: 0.5, alpha: 1.0).cgColor
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        descriptionTextView.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.1).cgColor
        descriptionTextView.layer.shadowOffset = CGSize(width: 0, height: 2)
        descriptionTextView.layer.shadowRadius = 4
        descriptionTextView.layer.shadowOpacity = 1.0
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionTextView)
    }
    
    func setupLocationLabel() {
        locationLabel = UILabel()
        locationLabel.text = "Location"
        locationLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        locationLabel.textColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(locationLabel)
    }
    
    func setupAddressField() {
        addressField = UITextField()
        addressField.placeholder = "Address or Lat/Long"
        addressField.borderStyle = .none
        addressField.font = UIFont.systemFont(ofSize: 16)
        addressField.backgroundColor = .white
        addressField.layer.cornerRadius = 12
        addressField.layer.borderWidth = 1.5
        addressField.layer.borderColor = UIColor(red: 0.5, green: 0.75, blue: 0.5, alpha: 1.0).cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: addressField.frame.height))
        addressField.leftView = paddingView
        addressField.leftViewMode = .always
        
        addressField.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.1).cgColor
        addressField.layer.shadowOffset = CGSize(width: 0, height: 2)
        addressField.layer.shadowRadius = 4
        addressField.layer.shadowOpacity = 1.0
        
        addressField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addressField)
    }
    
    func setupMapButton() {
        mapButton = UIButton(type: .system)
        mapButton.setTitle("", for: .normal)
        mapButton.setImage(UIImage(systemName: "map.fill"), for: .normal)
        mapButton.contentHorizontalAlignment = .fill
        mapButton.contentVerticalAlignment = .fill
        mapButton.imageView?.contentMode = .scaleAspectFit
        mapButton.tintColor = UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0)
        mapButton.backgroundColor = .white
        mapButton.layer.cornerRadius = 12
        mapButton.layer.borderWidth = 1.5
        mapButton.layer.borderColor = UIColor(red: 0.5, green: 0.75, blue: 0.5, alpha: 1.0).cgColor
        
        mapButton.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.1).cgColor
        mapButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        mapButton.layer.shadowRadius = 4
        mapButton.layer.shadowOpacity = 1.0
        
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapButton)
    }
    
    func setupSubmitPhotoLabel() {
        submitPhotoLabel = UILabel()
        submitPhotoLabel.text = "Submit Photo"
        submitPhotoLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        submitPhotoLabel.textColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        submitPhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(submitPhotoLabel)
    }
    
    func setupButtonSelectPhoto() {
        buttonSelectPhoto = UIButton(type: .system)
        buttonSelectPhoto.setTitle("", for: .normal)
        buttonSelectPhoto.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        buttonSelectPhoto.contentHorizontalAlignment = .fill
        buttonSelectPhoto.contentVerticalAlignment = .fill
        buttonSelectPhoto.imageView?.contentMode = .scaleAspectFit
        buttonSelectPhoto.tintColor = UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0)
        buttonSelectPhoto.backgroundColor = .white
        buttonSelectPhoto.layer.cornerRadius = 12
        buttonSelectPhoto.layer.borderWidth = 1.5
        buttonSelectPhoto.layer.borderColor = UIColor(red: 0.5, green: 0.75, blue: 0.5, alpha: 1.0).cgColor
        
        buttonSelectPhoto.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.1).cgColor
        buttonSelectPhoto.layer.shadowOffset = CGSize(width: 0, height: 2)
        buttonSelectPhoto.layer.shadowRadius = 4
        buttonSelectPhoto.layer.shadowOpacity = 1.0
        
        buttonSelectPhoto.showsMenuAsPrimaryAction = true
        buttonSelectPhoto.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(buttonSelectPhoto)
    }

    func setupSendReportButton() {
        sendReportButton = UIButton(type: .system)
        sendReportButton.setTitle("Send Report", for: .normal)
        sendReportButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        sendReportButton.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0)
        sendReportButton.setTitleColor(.white, for: .normal)
        sendReportButton.layer.cornerRadius = 12
        
        sendReportButton.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.3).cgColor
        sendReportButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        sendReportButton.layer.shadowRadius = 6
        sendReportButton.layer.shadowOpacity = 1.0
        
        sendReportButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sendReportButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            titleField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            titleField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            titleField.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 120),
            
            locationLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            addressField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            addressField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            addressField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            addressField.heightAnchor.constraint(equalToConstant: 50),
            
            mapButton.topAnchor.constraint(equalTo: addressField.bottomAnchor, constant: 16),
            mapButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mapButton.widthAnchor.constraint(equalToConstant: 200),
            mapButton.heightAnchor.constraint(equalToConstant: 150),
            
            submitPhotoLabel.topAnchor.constraint(equalTo: mapButton.bottomAnchor, constant: 20),
            submitPhotoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            
            buttonSelectPhoto.topAnchor.constraint(equalTo: submitPhotoLabel.bottomAnchor, constant: 8),
            buttonSelectPhoto.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonSelectPhoto.widthAnchor.constraint(equalToConstant: 200),
            buttonSelectPhoto.heightAnchor.constraint(equalToConstant: 150),
            
            sendReportButton.topAnchor.constraint(equalTo: buttonSelectPhoto.bottomAnchor, constant: 32),
            sendReportButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            sendReportButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            sendReportButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            sendReportButton.heightAnchor.constraint(equalToConstant: 50),
            sendReportButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
