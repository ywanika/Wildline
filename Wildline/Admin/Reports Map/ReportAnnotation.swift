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
    
    let subtitle: String?
//    let baseSubtitle = "Report from: \(report.createdBy)"
//    
//    if let address = addressSubtitle {
//        return "\(baseSubtitle)\n\(address)"
//    }
//    
//    return baseSubtitle
    
    init(report: Report) {
        self.report = report
        self.subtitle = "Report from: \(report.createdBy)"
        super.init()
    }
}
