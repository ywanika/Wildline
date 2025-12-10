//
//  Untitled.swift
//  Wildline
//
//  Created by Anika Sharma on 12/10/25.
//

import Foundation
import FirebaseFirestore

struct Status: Codable {
    @DocumentID var id: String?
    var type: UpdateTypes
    var message: String
    var createdAt: Date
    
    init(type: UpdateTypes, message: String, createdAt: Date) {
        self.type = type
        self.message = message
        self.createdAt = createdAt
    }
}
