//
//  ReportsMapViewController.swift
//  Wildline
//
//  Created by Anika Sharma on 11/17/25.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseFirestore

class ReportsMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let reportsMapView = ReportsMapView()
    
    private var locationManager = CLLocationManager()
    private var reports: [Report] = []

    override func loadView() {
        view = reportsMapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reports"
        
        reportsMapView.mapView.delegate = self
        setupLocationManager()
        
        fetchReportsAndLoadAnnotations()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func fetchReportsAndLoadAnnotations() {
        Task {
            do {
                let db = Firestore.firestore()
                let snapshot = try await db.collection("reports").getDocuments()
                
                self.reports = snapshot.documents.compactMap { doc in
                    try? doc.data(as: Report.self)
                }
                
                self.addReportAnnotations()
            } catch {
                print("Error fetching reports: \(error)")
            }
        }
    }
    
    private func addReportAnnotations() {
        reportsMapView.mapView.removeAnnotations(reportsMapView.mapView.annotations)
        
        for report in reports {
            let annotation = ReportAnnotation(report: report)
            reportsMapView.mapView.addAnnotation(annotation)
        }
        
        if !reports.isEmpty {
            reportsMapView.mapView.showAnnotations(reportsMapView.mapView.annotations, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? ReportAnnotation else { return }
        
        let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            var addressString: String = "Address not found"
            
            if let placemark = placemarks?.first {
                addressString = [placemark.thoroughfare, placemark.locality, placemark.administrativeArea]
                    .compactMap { $0 }
                    .joined(separator: ", ")
                
                annotation.addressSubtitle = addressString
            }
            
            if view.isSelected {
                mapView.deselectAnnotation(annotation, animated: false)
                mapView.selectAnnotation(annotation, animated: false)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let annotation = view.annotation as? ReportAnnotation {
            annotation.addressSubtitle = nil
        }
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? ReportAnnotation,
              control == view.rightCalloutAccessoryView else { return }
        
        let quickLookVC = QuickLookViewController()
        
        quickLookVC.reportInfo = annotation.report
        
        self.navigationController?.pushViewController(quickLookVC, animated: true)
        
        mapView.deselectAnnotation(annotation, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        
        let reuseId = "reportPin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.pinTintColor = .systemRed
            
            let rightButton = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = rightButton
            
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            reportsMapView.mapView.showsUserLocation = true
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        if reports.isEmpty {
            let coordinate = location.coordinate
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            reportsMapView.mapView.setRegion(region, animated: true)
        }
        
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed: \(error)")
    }
}
