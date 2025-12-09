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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        createdBy = try container.decode(String.self, forKey: .createdBy)
        userEmail = try container.decode(String.self, forKey: .userEmail)
        userPhoneNumber = try container.decode(String.self, forKey: .userPhoneNumber)
        location = try container.decode(GeoPoint.self, forKey: .location)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        assignedTo = try container.decode(String.self, forKey: .assignedTo)
    }
    
//    init(title: String? = nil, createdBy: String? = nil, userEmail: String? = nil, userPhoneNumber: String? = nil, description: String? = nil, location: String? = nil, status: String? = nil, createdAt: String? = nil, assignedTo: String? = nil) {
//        self.title = title
//        self.createdBy = createdBy
//        self.userEmail = userEmail
//        self.userPhoneNumber = userPhoneNumber
//        self.description = description
//        self.location = location
//        self.status = status
//        self.createdAt = createdAt
//        self.assignedTo = assignedTo
//    }
    
    /**
     @DocumentID var id: String?
     var email: String
     var name: String
     var phoneNumber: String
     var role: Roles
     
     
     init(email: String, name: String, phoneNumber: String, role: Roles) {
         self.email = email
         self.name = name
         self.phoneNumber = phoneNumber
         self.role = role
     }
     
     init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         id = try container.decodeIfPresent(String.self, forKey: .id)
         email = try container.decode(String.self, forKey: .email)
         name = try container.decode(String.self, forKey: .name)
         phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
         role = try container.decode(Roles.self, forKey: .role)
     }
     */
}
