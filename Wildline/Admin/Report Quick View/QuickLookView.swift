//
//  QuickLookView.swift
//  Wildline
//
//  Created by Anika Sharma on 11/16/25.
//

import UIKit

class QuickLookView: UIView {

    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var reporterNameLabel: UILabel!
    var reporterPictureButton: UIButton!
    var titleLabel: UILabel!
    var locationLabel: UILabel!
    var descriptionLabel: UILabel!
    var claimReportButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
                
        //MARK: initializing the UI elements and constraints...
        setupScrollView()
        setupContentView()
        setupReporterNameLabel()
        setupReporterPictureButton()
        setupTitleLabel()
        setupLocationLabel()
        setupDescriptionLabel()
        setupClaimReportButton()
        
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
    
    func setupReporterNameLabel() {
        reporterNameLabel = UILabel()
        reporterNameLabel.text = "Reporter name"
        reporterNameLabel.font = UIFont.systemFont(ofSize: 16)
        reporterNameLabel.textAlignment = .right
        reporterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(reporterNameLabel)
    }
    
    func setupReporterPictureButton() {
        reporterPictureButton = UIButton(type: .system)
        reporterPictureButton.setTitle("", for: .normal)
        reporterPictureButton.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        reporterPictureButton.contentHorizontalAlignment = .fill
        reporterPictureButton.contentVerticalAlignment = .fill
        reporterPictureButton.imageView?.contentMode = .scaleAspectFit
        reporterPictureButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(reporterPictureButton)
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
    }
    
    func setupLocationLabel() {
        locationLabel = UILabel()
        locationLabel.text = "Location • X mi"
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.textColor = .systemGray
        locationLabel.numberOfLines = 0
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(locationLabel)
    }
    
    func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.text = "Description"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
    }
    
    func setupClaimReportButton() {
        claimReportButton = UIButton(type: .system)
        claimReportButton.translatesAutoresizingMaskIntoConstraints = false
        claimReportButton.setTitle("Claim Report", for: .normal)
        claimReportButton.backgroundColor = .systemBlue
        claimReportButton.setTitleColor(.white, for: .normal)
        claimReportButton.layer.cornerRadius = 8
        contentView.addSubview(claimReportButton)
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
            
            reporterPictureButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            reporterPictureButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            reporterPictureButton.widthAnchor.constraint(equalToConstant: 40),
            reporterPictureButton.heightAnchor.constraint(equalToConstant: 40),
            
            reporterNameLabel.centerYAnchor.constraint(equalTo: reporterPictureButton.centerYAnchor),
            reporterNameLabel.trailingAnchor.constraint(equalTo: reporterPictureButton.leadingAnchor, constant: -8),
            reporterNameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: reporterNameLabel.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            claimReportButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            claimReportButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            claimReportButton.widthAnchor.constraint(equalToConstant: 200),
            claimReportButton.heightAnchor.constraint(equalToConstant: 44),
            claimReportButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
