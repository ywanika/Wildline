//
//  LocationSelectionDelegate.swift
//  Wildline
//
//  Created by [Your Name]
//

import CoreLocation

// Define the contract for communication between the MapVC and the ReportVC
protocol LocationSelectionDelegate: AnyObject {
    
    // Called by the MapVC when the user confirms the pin location
    func didSelectLocation(latitude: Double, longitude: Double, address: String?)
    
    // Called by the MakeReportView when the map button is tapped
    func mapButtonTapped()
    
    // GPS method
    func requestCurrentGPSLocation()
}
