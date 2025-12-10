//
//  QuickLookViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 11/17/25.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseFirestore

class QuickLookViewController: UIViewController {
    let db = Firestore.firestore()

    var quickLookView = QuickLookView()
    var reportInfo: Report!
    var currentUser:FirebaseAuth.User?
    
    override func loadView(){
        view = quickLookView
        
        quickLookView.titleLabel.text = reportInfo.title
        quickLookView.descriptionTextView.text = reportInfo.description
        quickLookView.reporterNameLabel.text = "Reported By: \(reportInfo.createdBy)"
        
        if reportInfo.adminName.isEmpty == true || reportInfo.adminName == "" {
            quickLookView.claimReportButton.isHidden = false
            quickLookView.claimReportButton.addTarget(self, action: #selector(onClaimReportButtonTapped), for: .touchUpInside)
        } else {
            quickLookView.claimReportButton.isHidden = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPin()
    }
    
    @objc func onClaimReportButtonTapped() {
        claimReport()
        quickLookView.claimReportButton.isHidden = true
        navigationController?.popViewController(animated: true)
    }
    
    private func addPin() {
        let coordinate = CLLocationCoordinate2D(
            latitude: reportInfo.location.latitude,
            longitude: reportInfo.location.longitude
        )
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Report Location"
        
        quickLookView.mapPreview.addAnnotation(annotation)
        
        // Center and zoom the map on the pin
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
        quickLookView.mapPreview.setRegion(region, animated: false)
    }

}
