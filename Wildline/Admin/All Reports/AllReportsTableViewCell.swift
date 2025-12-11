//
//  AllReportsTableViewCell.swift
//  Wildline
//
//  Created by Max Grotstein on 11/17/25.
//

import UIKit

class AllReportsTableViewCell: UITableViewCell {
    static let identifier = "AllReportsTableViewCell"

    var wrapperCellView: UIView!
    var titleLabel: UILabel!
    var timeLabel: UILabel!
//    var distanceLabel: UILabel!
    var statusLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.95, alpha: 1.0)
        
        setupWrapperCellView()
        setupTitleLabel()
        setupTimeLabel()
//        setupDistanceLabel()
        setupStatusLabel()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 4.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 2.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupTitleLabel(){
        titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(titleLabel)
    }
    
    func setupTimeLabel() {
        timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.numberOfLines = 0
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(timeLabel)
    }
    
//    func setupDistanceLabel() {
//        distanceLabel = UILabel()
//        distanceLabel.font = UIFont.systemFont(ofSize: 14)
//        distanceLabel.numberOfLines = 0
//        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
//        wrapperCellView.addSubview(distanceLabel)
//    }
    
    func setupStatusLabel() {
        statusLabel = UILabel()
        statusLabel.font = UIFont.boldSystemFont(ofSize: 16)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(statusLabel)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            
            titleLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.widthAnchor.constraint(equalTo: wrapperCellView.widthAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            timeLabel.heightAnchor.constraint(equalToConstant: 20),
            timeLabel.widthAnchor.constraint(equalTo: wrapperCellView.widthAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            statusLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),
            statusLabel.widthAnchor.constraint(equalTo: wrapperCellView.widthAnchor),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
