//
//  QuickLookViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 11/17/25.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseFirestore
import MapKit

class QuickLookViewController: UIViewController {
    let db = Firestore.firestore()

    var quickLookView = QuickLookView()
    var reportInfo: Report!
    var currentUser:FirebaseAuth.User?
    let notificationCenter = NotificationCenter.default
    
    override func loadView(){
        view = quickLookView
        
        quickLookView.titleLabel.text = reportInfo.title
        quickLookView.descriptionTextView.text = reportInfo.description
        quickLookView.reporterNameLabel.text = "Reported By: \(reportInfo.createdBy)"
        
        reverseGeocodeLocation()
        
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
    
    func reverseGeocodeLocation() {
        let location = CLLocation(latitude: reportInfo.location.latitude, longitude: reportInfo.location.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            var addressString: String = "Location Address Not Found"
            
            if let placemark = placemarks?.first {
                addressString = [placemark.thoroughfare, placemark.locality, placemark.administrativeArea]
                    .compactMap { $0 }
                    .joined(separator: ", ")
            }
            
            DispatchQueue.main.async {
                            self.quickLookView.updateLocationDisplay(address: addressString, distance: nil)
                        }
        }
    }

    @objc func onClaimReportButtonTapped() {
        claimReport()
        quickLookView.claimReportButton.isHidden = true
        
        print("about to send notif")
        notificationCenter.post(name: Notification.Name("reloadReports"), object: nil)
        print("should have sent notif")
        
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
