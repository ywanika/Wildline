//
//  Validators.swift
//  Wildline
//
//  Created by Student on 12/9/25.
//

import Foundation
import FirebaseFirestore

func isValidReport(createdBy: String, userEmail: String, userPhoneNumber: String, title: String, description: String, location: String, createdAt: Date) -> Bool {
    if (createdBy.isEmpty || userEmail.isEmpty || userPhoneNumber.isEmpty || title.isEmpty || description.isEmpty || location.isEmpty) {
        return false
    } 
    return true
}

func isValidCoordinate(latitude: Double, longitude: Double) -> Bool {
    return latitude >= -90 && latitude <= 90 &&
           longitude >= -180 && longitude <= 180
}
