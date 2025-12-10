//
//  MapViewController.swift
//  Wildline
//
//  Created by Ciara Hanley
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    weak var locationDelegate: LocationSelectionDelegate?

    private let mapView = MKMapView()
    private let selectButton = UIButton(type: .system)
    
    private var selectedCoordinate: CLLocationCoordinate2D?
    private var geocoder = CLGeocoder()
    private var locationManager = CLLocationManager() // Location Manager instance

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addLongPressGesture()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func setupUI() {
        title = "Select Location"
        view.backgroundColor = .systemBackground
        
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)

        selectButton.setTitle("Confirm Location", for: .normal)
        selectButton.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 0.35, alpha: 1.0)
        selectButton.setTitleColor(.white, for: .normal)
        selectButton.layer.cornerRadius = 10
        selectButton.addTarget(self, action: #selector(selectLocationTapped), for: .touchUpInside)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectButton)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: selectButton.topAnchor, constant: -16),
            
            selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            selectButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func centerMapOnDefault() {
        let defaultCoordinate = CLLocationCoordinate2D(latitude: 39.8283, longitude: -98.5795) // Center of US
        let region = MKCoordinateRegion(center: defaultCoordinate, latitudinalMeters: 5000000, longitudinalMeters: 5000000)
        mapView.setRegion(region, animated: false)
    }

    private func centerMapOnLocation(coordinate: CLLocationCoordinate2D, latitudinalMeters: CLLocationDistance = 1000, animated: Bool = true) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: latitudinalMeters, longitudinalMeters: latitudinalMeters)
        mapView.setRegion(region, animated: animated)
    }

    private func addLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mapView.addGestureRecognizer(longPress)
    }

    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }

        // Convert screen point to geographical coordinate
        let touchPoint = gestureRecognizer.location(in: mapView)
        let mapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        // Store selection and update pin
        selectedCoordinate = mapCoordinate
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapCoordinate
        annotation.title = "Report Location"
        mapView.addAnnotation(annotation)
        
        // Zoom in slightly on the dropped pin
        centerMapOnLocation(coordinate: mapCoordinate, latitudinalMeters: 500)
    }

    @objc func selectLocationTapped() {
        guard let coord = selectedCoordinate else {
            let alert = UIAlertController(title: "Selection Required", message: "Please long-press the map to drop a pin.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        // Reverse Geocode the coordinate to get a readable address
        let location = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            var addressString: String? = nil
            
            if let placemark = placemarks?.first {
                // Construct a useful address string (e.g., Street, City, State)
                addressString = [placemark.thoroughfare, placemark.locality, placemark.administrativeArea]
                    .compactMap { $0 }
                    .joined(separator: ", ")
            }
            
            // Pass the data back to the Report VC via the delegate
            self?.locationDelegate?.didSelectLocation(
                latitude: coord.latitude,
                longitude: coord.longitude,
                address: addressString
            )

            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - MKMapViewDelegate (Pin Customization and Dragging)

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Do not customize the blue user location dot
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }

        let reuseID = "ReportPin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout = true
            pinView?.animatesDrop = true
            // Enable pin dragging for adjustment
            pinView?.isDraggable = true
            pinView?.pinTintColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0)
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    // Update selected coordinate when the user finishes dragging the pin
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        if newState == .ending {
            if let newCoordinate = view.annotation?.coordinate {
                self.selectedCoordinate = newCoordinate
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate (User Location Handling)
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Permission granted: Request current location
            manager.requestLocation()
            
        case .denied, .restricted:
            // Permission denied: Fall back to default map center
            centerMapOnDefault()
            
        case .notDetermined:
            break
            
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let coordinate = location.coordinate
        
        // Only set and drop the pin if one hasn't been set manually via long press
        if selectedCoordinate == nil {
            selectedCoordinate = coordinate
            
            // Drop an initial pin at the user's GPS location
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Current Location (Drag to adjust)"
            mapView.addAnnotation(annotation)
            
            // Center map and zoom in
            centerMapOnLocation(coordinate: coordinate)
        }
        
        // Stop updates after first location received
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed: \(error.localizedDescription)")
        // Fallback to default if GPS fails after authorization
        centerMapOnDefault()
    }
}
