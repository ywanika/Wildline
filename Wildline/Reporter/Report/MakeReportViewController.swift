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
    var locationManager: CLLocationManager?

    override func loadView(){
        view = makeReportView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Make a Report"
        makeReportView.buttonSelectPhoto.menu = getMenuImagePicker()
        
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
    
    func getMenuImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    //MARK: take Photo using Camera...
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
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
                let currentUser = try await getUser(for:currentUserDocId)
                let createdBy = currentUser.name
                let userEmail = currentUser.email
                let userPhoneNumber = currentUser.phoneNumber
                let title = makeReportView.titleField.text
                let description = makeReportView.descriptionTextView.text
                let location = makeReportView.addressField.text
                let createdAt = Date()
                
                
                let locationGeoPoint = GeoPoint(latitude: latitude, longitude: longitude)
                
                let report = Report(
                    title: title!,
                    createdBy: createdBy,
                    userEmail: userEmail,
                    userPhoneNumber: userPhoneNumber,
                    description: description,
                    location: locationGeoPoint,
                    createdAt: createdAt
                )
                
                try await self.createReport(report: report)
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

//MARK: adopting required protocols for UIImagePicker...
extension MakeReportViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.makeReportView.buttonSelectPhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}

//MARK: adopting required protocols for PHPicker...
extension MakeReportViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.makeReportView.buttonSelectPhoto.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
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
