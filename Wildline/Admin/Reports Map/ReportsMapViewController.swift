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
    private var geocodingTimer: Timer?
    let notificationCenter = NotificationCenter.default

    override func loadView() {
        view = reportsMapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reports"
        
        reportsMapView.mapView.delegate = self
        setupLocationManager()
        
        fetchReportsAndLoadAnnotations()
        
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForReportRefresh(notification:)),
            name: Notification.Name("reloadReports"),
            object: nil
        )
    }
    
    @MainActor
    private func forceMapRefresh() {
        // Remove all annotations
        let allAnnotations = reportsMapView.mapView.annotations
        reportsMapView.mapView.removeAnnotations(allAnnotations)
        
        // Force the map to update
        reportsMapView.mapView.setNeedsDisplay()
        
        // Re-add annotations on next run loop
        DispatchQueue.main.async { [weak self] in
            self?.addReportAnnotations()
        }
    }
    
    @MainActor
    @objc func notificationReceivedForReportRefresh(notification: Notification) {
        
        fetchReportsAndLoadAnnotations()
        
        // Force refresh after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.forceMapRefresh()
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    @MainActor
    private func fetchReportsAndLoadAnnotations() {
        Task {
            do {
                let db = Firestore.firestore()
                let snapshot = try await db.collection("reports").whereField("adminName", in: [NSNull(), ""]).getDocuments()
                
                self.reports = snapshot.documents.compactMap { doc in
                    try? doc.data(as: Report.self)
                }
                
                self.addReportAnnotations()
            } catch {
                print("Error fetching reports: \(error)")
            }
        }
    }
    
    @MainActor
    private func addReportAnnotations() {
        reportsMapView.mapView.removeAnnotations(reportsMapView.mapView.annotations)
        
        for report in reports {
            let annotation = ReportAnnotation(report: report)
            reportsMapView.mapView.addAnnotation(annotation)
        }
        
        if !reports.isEmpty {
            // Get only the ReportAnnotation objects (exclude user location)
            let reportAnnotations = reportsMapView.mapView.annotations.filter { $0 is ReportAnnotation }
            reportsMapView.mapView.showAnnotations(reportAnnotations, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Don't geocode at all - just show the report info
        guard let annotation = view.annotation as? ReportAnnotation else { return }
        print("Selected report: \(annotation.report.title)")
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
