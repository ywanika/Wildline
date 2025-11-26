//
//  HomeView.swift
//  Wildline
//
//  Created by Max Grotstein on 11/13/25.
//

import UIKit

class HomeView: UIView {
    
    var reportsTable: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Soft gradient background matching login
        self.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.95, alpha: 1.0)
        
        setupReportsTable()
        
        initConstraints()
    }
    
    func setupReportsTable() {
        reportsTable = UITableView()
        reportsTable.register(ReportTableCellView.self, forCellReuseIdentifier: "id")
        reportsTable.translatesAutoresizingMaskIntoConstraints = false
        
        // Style the table view
        reportsTable.backgroundColor = .clear
        reportsTable.separatorStyle = .none
        reportsTable.showsVerticalScrollIndicator = false
        
        // Add rounded corners and shadow
        reportsTable.layer.cornerRadius = 16
        reportsTable.layer.masksToBounds = false
        reportsTable.layer.shadowColor = UIColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 0.1).cgColor
        reportsTable.layer.shadowOffset = CGSize(width: 0, height: 2)
        reportsTable.layer.shadowRadius = 8
        reportsTable.layer.shadowOpacity = 1.0
        
        // Add some spacing between cells
        reportsTable.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        self.addSubview(reportsTable)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            reportsTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            reportsTable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            reportsTable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            reportsTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
