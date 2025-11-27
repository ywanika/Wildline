//
//  EducationView.swift
//  Final Project
//
//  Created by Student on 11/16/25.
//

import UIKit

class EducationView: UIView {

    var whatToDoLabel: UILabel!
    var fillLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupWhatToDoLabel()
        setupFillLabel()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWhatToDoLabel() {
        whatToDoLabel = UILabel()
        whatToDoLabel.text = "What to do:"
        whatToDoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(whatToDoLabel)
    }
    
    func setupFillLabel() {
        fillLabel = UILabel()
        fillLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        fillLabel.numberOfLines = 0
        fillLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(fillLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            whatToDoLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            whatToDoLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            whatToDoLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            fillLabel.topAnchor.constraint(equalTo: whatToDoLabel.bottomAnchor, constant: 20),
            fillLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            fillLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}
