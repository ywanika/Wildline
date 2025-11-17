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
        
        self.backgroundColor = .white
                
        //MARK: initializing the UI elements and constraints...
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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
    }
    
    func setupTitleField() {
        titleField = UITextField()
        titleField.textAlignment = .left
        titleField.borderStyle = UITextField.BorderStyle(rawValue: 1)!
        titleField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleField)
    }
    
    func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
    }
    
    func setupDescriptionTextView() {
        descriptionTextView = UITextView()
        descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionTextView)
    }
    
    func setupLocationLabel() {
        locationLabel = UILabel()
        locationLabel.text = "Location"
        locationLabel.font = UIFont.boldSystemFont(ofSize: 18)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(locationLabel)
    }
    
    func setupAddressField() {
        addressField = UITextField()
        addressField.textAlignment = .left
        addressField.borderStyle = UITextField.BorderStyle(rawValue: 1)!
        addressField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addressField)
        addressField.placeholder = "Address or Lat/Long"
    }
    
    func setupMapButton() {
        mapButton = UIButton(type: .system)
        mapButton.setTitle("", for: .normal)
        mapButton.setImage(UIImage(systemName: "map.fill"), for: .normal)
        mapButton.contentHorizontalAlignment = .fill
        mapButton.contentVerticalAlignment = .fill
        mapButton.imageView?.contentMode = .scaleAspectFit
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapButton)
    }
    
    func setupSubmitPhotoLabel() {
        submitPhotoLabel = UILabel()
        submitPhotoLabel.text = "Submit Photo"
        submitPhotoLabel.font = UIFont.boldSystemFont(ofSize: 16)
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
        buttonSelectPhoto.translatesAutoresizingMaskIntoConstraints = false
        buttonSelectPhoto.showsMenuAsPrimaryAction = true
        contentView.addSubview(buttonSelectPhoto)
    }

    func setupSendReportButton() {
        sendReportButton = UIButton(type: .system)
        sendReportButton.translatesAutoresizingMaskIntoConstraints = false
        sendReportButton.setTitle("Send Report", for: .normal)
        sendReportButton.backgroundColor = .systemRed
        sendReportButton.setTitleColor(.white, for: .normal)
        sendReportButton.layer.cornerRadius = 8
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
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            titleField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 120),
            
            locationLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            addressField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            addressField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            addressField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            mapButton.topAnchor.constraint(equalTo: addressField.bottomAnchor, constant: 20),
            mapButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mapButton.widthAnchor.constraint(equalToConstant: 200),
            mapButton.heightAnchor.constraint(equalToConstant: 150),
            
            submitPhotoLabel.topAnchor.constraint(equalTo: mapButton.bottomAnchor, constant: 20),
            submitPhotoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            buttonSelectPhoto.topAnchor.constraint(equalTo: submitPhotoLabel.bottomAnchor, constant: 10),
            buttonSelectPhoto.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonSelectPhoto.widthAnchor.constraint(equalToConstant: 200),
            buttonSelectPhoto.heightAnchor.constraint(equalToConstant: 150),
            
            sendReportButton.topAnchor.constraint(equalTo: buttonSelectPhoto.bottomAnchor, constant: 30),
            sendReportButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            sendReportButton.widthAnchor.constraint(equalToConstant: 200),
            sendReportButton.heightAnchor.constraint(equalToConstant: 44),
            sendReportButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
