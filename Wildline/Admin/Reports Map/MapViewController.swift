//
//  MapViewController.swift
//  Wildline
//
//  Created by Ciara Hanley
//

import UIKit
import MapKit
import CoreLocation

// MODIFIED: Added delegates for search and table view
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, MKLocalSearchCompleterDelegate, UITableViewDataSource, UITableViewDelegate {

    weak var locationDelegate: LocationSelectionDelegate?

    private let mapView = MKMapView()
    private let selectButton = UIButton(type: .system)
    
    // NEW SEARCH PROPERTIES
    private let searchTextField = UITextField()
    private let resultsTableView = UITableView()
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults: [MKLocalSearchCompletion] = []
    
    private var selectedCoordinate: CLLocationCoordinate2D?
    private var geocoder = CLGeocoder()
    private var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        addLongPressGesture()
        setupLocationManager()
        setupSearch() // NEW
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    // NEW: Setup search completer
    private func setupSearch() {
        searchCompleter.delegate = self
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
        
        // NEW: Setup Search Text Field
        searchTextField.placeholder = "Enter Address or Location..."
        searchTextField.borderStyle = .roundedRect
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        view.addSubview(searchTextField)
        
        // NEW: Setup Results Table View
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.isHidden = true
        resultsTableView.translatesAutoresizingMaskIntoConstraints = false
        resultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchResultCell")
        view.addSubview(resultsTableView)

        NSLayoutConstraint.activate([
            // New searchTextField constraints
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Adjust mapView top constraint
            mapView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 8),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: selectButton.topAnchor, constant: -16),
            
            // New resultsTableView constraints
            resultsTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 2),
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resultsTableView.heightAnchor.constraint(equalToConstant: 200),
            
            selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            selectButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func centerMapOnDefault() {
        let defaultCoordinate = CLLocationCoordinate2D(latitude: 39.8283, longitude: -98.5795)
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

        let touchPoint = gestureRecognizer.location(in: mapView)
        let mapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        selectedCoordinate = mapCoordinate
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapCoordinate
        annotation.title = "Report Location"
        mapView.addAnnotation(annotation)
        
        centerMapOnLocation(coordinate: mapCoordinate, latitudinalMeters: 500)
        
        // Clear search results when long-pressing
        resultsTableView.isHidden = true
        searchTextField.resignFirstResponder()
        searchTextField.text = nil
    }

    @objc func selectLocationTapped() {
        guard let coord = selectedCoordinate else {
            let alert = UIAlertController(title: "Selection Required", message: "Please long-press the map to drop a pin.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let location = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            var addressString: String? = nil
            
            if let placemark = placemarks?.first {
                addressString = [placemark.thoroughfare, placemark.locality, placemark.administrativeArea]
                    .compactMap { $0 }
                    .joined(separator: ", ")
            }
            
            self?.locationDelegate?.didSelectLocation(
                latitude: coord.latitude,
                longitude: coord.longitude,
                address: addressString
            )

            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - MKLocalSearchCompleterDelegate
    
    @objc private func searchTextChanged(_ textField: UITextField) {
        guard let query = textField.text, !query.isEmpty else {
            resultsTableView.isHidden = true
            return
        }
        searchCompleter.queryFragment = query
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        resultsTableView.reloadData()
        resultsTableView.isHidden = completer.results.isEmpty
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Search completer failed: \(error.localizedDescription)")
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        let result = searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.subtitle
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        resultsTableView.isHidden = true
        searchTextField.resignFirstResponder()

        let completion = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { [weak self] (response, error) in
            guard let self = self, let mapItem = response?.mapItems.first else {
                print("Error during search: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            let coordinate = mapItem.placemark.coordinate
            self.selectedCoordinate = coordinate

            self.mapView.removeAnnotations(self.mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = mapItem.name ?? "Searched Location"
            self.mapView.addAnnotation(annotation)
            
            self.centerMapOnLocation(coordinate: coordinate, latitudinalMeters: 500)
            
            self.searchTextField.text = mapItem.name ?? completion.title
        }
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }

        let reuseID = "ReportPin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView?.canShowCallout = true
            pinView?.animatesDrop = true
            pinView?.isDraggable = false
            pinView?.pinTintColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 1.0)
            
            let infoButton = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = infoButton
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    // Add this new delegate method to handle the info button tap
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("Info button tapped!") // Debug print

        guard let reportAnnotation = view.annotation as? ReportAnnotation else {
            print("Failed to cast annotation")
            return
        }
        
        print("Report: \(reportAnnotation.report.title)") // Debug print

        
        // Navigate to the report details screen
        let detailVC = ReportDetailsViewController()
        detailVC.reportInfo = reportAnnotation.report
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        if newState == .ending {
            if let newCoordinate = view.annotation?.coordinate {
                self.selectedCoordinate = newCoordinate
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
            
        case .denied, .restricted:
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
        
        if selectedCoordinate == nil {
            selectedCoordinate = coordinate
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Current Location (Drag to adjust)"
            mapView.addAnnotation(annotation)
            
            centerMapOnLocation(coordinate: coordinate)
        }
        
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed: \(error.localizedDescription)")
        centerMapOnDefault()
    }
}
