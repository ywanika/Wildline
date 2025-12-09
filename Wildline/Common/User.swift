//
//  User.swift
//  Wildline
//
//  Created by Max Grotstein on 12/7/25.
//

import Foundation
import FirebaseFirestore

struct User: Codable {
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
}
