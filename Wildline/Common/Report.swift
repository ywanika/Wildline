//
//  Report.swift
//  Wildline
//
//  Created by Student on 11/26/25.
//

import Foundation
import FirebaseFirestore

struct Report: Codable {
    @DocumentID var id: String?
    var title: String
    var createdBy: String
    var userEmail: String
    var userPhoneNumber: String
    var description: String?
    var location: GeoPoint
    var createdAt: Date
    var assignedTo: String?
    
    init(title: String, createdBy: String, userEmail: String, userPhoneNumber: String, description: String? = nil, location: GeoPoint, createdAt: Date, assignedTo: String? = nil) {
        self.title = title
        self.createdBy = createdBy
        self.userEmail = userEmail
        self.userPhoneNumber = userPhoneNumber
        self.description = description
        self.location = location
        self.createdAt = createdAt
        self.assignedTo = assignedTo
    }
}
