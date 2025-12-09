//
//  EducationView.swift
//  Final Project
//
//  Created by Student on 11/16/25.
//

import UIKit

class EducationView: UIView {

    var scrollView: UIScrollView!
    var contentStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.95, alpha: 1.0)
        
        setupScrollView()
        setupContentStackView()
        addArticles()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
    func setupContentStackView() {
        contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)
    }
    
    func addArticles() {
        let articles = [
            ("What to Do When You Find Injured Wildlife", "If you encounter injured wildlife, maintain a safe distance and avoid direct contact. Call your local wildlife rehabilitation center immediately. Keep pets and children away from the animal."),
            ("Identifying Common Wildlife Species", "Learn to recognize local wildlife species in your area. Understanding different animals helps you report sightings accurately and know which species may need special attention or protection."),
            ("Creating Wildlife-Friendly Habitats", "Support local wildlife by planting native species, providing water sources, and creating shelter. Avoid using pesticides and keep outdoor cats indoors to protect vulnerable wildlife populations."),
            ("When to Report Wildlife Sightings", "Report sightings of endangered species, injured animals, or wildlife in unusual locations. Document the date, time, location, and behavior. Photos can help experts assess the situation."),
            ("Understanding Wildlife Behavior", "Most wildlife avoids human contact. If an animal appears aggressive or unafraid, it may be sick or injured. Never attempt to feed or touch wild animals, even if they seem friendly."),
            ("Seasonal Wildlife Care Tips", "Different seasons bring different wildlife needs. Spring brings babies that may appear abandoned but often aren't. Winter requires extra care for animals struggling with food scarcity."),
        ]
        
        for (title, description) in articles {
            let articleCard = createArticleCard(title: title, description: description)
            contentStackView.addArrangedSubview(articleCard)
        }
    }
    
    func createArticleCard(title: String, description: String) -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 16
        cardView.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.1).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 8
        cardView.layer.shadowOpacity = 1.0
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        let accentBorder = UIView()
        accentBorder.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0)
        accentBorder.layer.cornerRadius = 2
        accentBorder.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(accentBorder)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(titleLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        descriptionLabel.textColor = UIColor(red: 0.3, green: 0.35, blue: 0.3, alpha: 1.0)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(descriptionLabel)
        
        let readMoreButton = UIButton(type: .system)
        readMoreButton.setTitle("Read More →", for: .normal)
        readMoreButton.setTitleColor(UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0), for: .normal)
        readMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        readMoreButton.contentHorizontalAlignment = .left
        readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(readMoreButton)
        
        NSLayoutConstraint.activate([
            accentBorder.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            accentBorder.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            accentBorder.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),
            accentBorder.widthAnchor.constraint(equalToConstant: 4),
            
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: accentBorder.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            readMoreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            readMoreButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            readMoreButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),
            readMoreButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        
        return cardView
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
        ])
    }
}
