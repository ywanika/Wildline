//
//  MakeReportViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 11/15/25.
//

import UIKit
import PhotosUI
import FirebaseFirestore
import MapKit
import CoreLocation

class MakeReportViewController: UIViewController, CLLocationManagerDelegate {
    var makeReportView = MakeReportView()
    var pickedImage:UIImage?
    var currentUser: User!
    let db = Firestore.firestore()
    var locationManager: CLLocationManager?

    override func loadView(){
        view = makeReportView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Make a Report"
        
        makeReportView.delegate = self
        setupLocationManager()
        
        makeReportView.sendReportButton.addTarget(self, action: #selector(onSendTapped), for: .touchUpInside)
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager?.requestWhenInUseAuthorization()
    }
    
    @objc func onSendTapped() {
        guard let currentUserDocId = UserToken.shared.getUserId() else {
            print("Current user id is nil")
            return
        }
        
        guard let latitude = makeReportView.selectedLatitude,
              let longitude = makeReportView.selectedLongitude else {
            // Display an alert if location is not set
            print("Location required!")
            return
        }
        
        Task {
            do {
//                guard let currentUser = try await getUser(for:currentUserDocId) else {
//                    showAlert(on: self, title: "Error", message: "Could not fetch user data.")
//                }
                let currentUser = try await Utilities.getUser(for:currentUserDocId)
                let createdBy = currentUser.name
                let userEmail = currentUser.email
                let userPhoneNumber = currentUser.phoneNumber
                let title = makeReportView.titleField.text
                let description = makeReportView.descriptionTextView.text
                let location = makeReportView.addressField.text
                let createdAt = Date()
                
                
                let locationGeoPoint = GeoPoint(latitude: latitude, longitude: longitude)
                
//                let report = Report(
//                    title: title!,
//                    createdBy: createdBy,
//                    userEmail: userEmail,
//                    userPhoneNumber: userPhoneNumber,
//                    description: description,
//                    location: locationGeoPoint,
//                    createdAt: createdAt
//                )
                
//                guard let coords = Utilities.parseLocation(location: location ?? "") else {
//                   showAlert(on: self, title: "Alert!", message: "Location must be formatted as 'latitude/longitude'.")
//                   return
//                }
                
                let report = Report(title: title!, createdBy: createdBy, userEmail: userEmail, userPhoneNumber: userPhoneNumber,description: description, location: locationGeoPoint, createdAt: createdAt, adminName: "", adminPhoneNumber: "")
                
                if (!isValidReport(createdBy: createdBy, userEmail: userEmail, userPhoneNumber: userPhoneNumber, title: title ?? "", description: description ?? "", location: location ?? "", createdAt: createdAt)) {
                        showAlert(on: self, title: "Alert!", message: "Make sure you fill in all the required fields.")
                        return
                    }
            
                try await self.createReport(report: report, userId: currentUserDocId)
                showAlert(on: self, title: "Report Created!", message: "Your report has been successfully created")
            }
        }
    }
    
    func getUser(for uid: String) async throws -> User {
        
        
        let db = Firestore.firestore()
        
        let document = db.collection("users").document(uid)
        let snapshot = try await document.getDocument()
        
        let user = try snapshot.data(as: User.self)
        
        return user
    }
    
    // MARK: - CoreLocation Delegate Methods
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            var addressString: String? = nil
            if let placemark = placemarks?.first {
                addressString = [placemark.thoroughfare, placemark.locality, placemark.administrativeArea]
                    .compactMap { $0 }
                    .joined(separator: ", ")
            }
            
            self?.makeReportView.updateLocationDisplay(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude,
                address: addressString
            )
        }
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error)")
        // Add alert to inform user that GPS failed if desired
    }
}

// MARK: - LocationSelectionDelegate Implementation
extension MakeReportViewController: LocationSelectionDelegate {

    func requestCurrentGPSLocation() {
        let status = locationManager?.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("Location access denied. Prompting user to enable in settings.")
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager?.requestLocation()
        case .none:
            break
        @unknown default:
            break
        }
    }
    
    func mapButtonTapped() {
        let mapVC = MapViewController()
        mapVC.locationDelegate = self
        navigationController?.pushViewController(mapVC, animated: true)
    }

    func didSelectLocation(latitude: Double, longitude: Double, address: String?) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        makeReportView.updateLocationDisplay(latitude: latitude, longitude: longitude, address: address)

        makeReportView.updateMapPreview(coordinate: coordinate)
    }
}
