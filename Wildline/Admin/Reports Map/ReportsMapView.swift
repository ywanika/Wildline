//
//  ReportsMapView.swift
//  Wildline
//
//  Created by Max Grotstein on 11/13/25.
//

import UIKit
import MapKit

class ReportsMapView: UIView {
    
    var titleLabel: UILabel!
    var mapView: MKMapView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 0.95, alpha: 1.0)

        setupTitleLabel()
        setupMapView()
        
        initConstraints()
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Reports Near Me"
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupMapView() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mapView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            mapView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            mapView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
