//
//  AllReportsView.swift
//  Wildline
//
//  Created by Max Grotstein on 11/13/25.
//

import UIKit

class AllReportsView: UIView {

    var reportsTable: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.95, alpha: 1.0)
        
        setupReportsTable()
        
        initConstraints()
    }
    
    func setupReportsTable() {
        reportsTable = UITableView()
        reportsTable.backgroundColor = .clear
        reportsTable.register(AllReportsTableViewCell.self, forCellReuseIdentifier: "title")
        reportsTable.translatesAutoresizingMaskIntoConstraints = false
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
