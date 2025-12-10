//
//  ReportAnnotation.swift
//  Wildline
//
//  Created by Ciara Hanley on 12/10/25.
//

import MapKit
import FirebaseFirestore

class ReportAnnotation: NSObject, MKAnnotation {
    
    let report: Report
    
    // NEW: Property to hold the address after reverse geocoding
    var addressSubtitle: String?
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: report.location.latitude,
            longitude: report.location.longitude
        )
    }
    var title: String? {
        return report.title
    }
    
    // MODIFIED: Use override and conditionally display the fetched address
        var subtitle: String? {
        let baseSubtitle = "Report from: \(report.createdBy)"
        
        if let address = addressSubtitle {
            return "\(baseSubtitle)\n\(address)"
        }
        
        return baseSubtitle
    }
    
    init(report: Report) {
        self.report = report
        super.init()
    }
}
