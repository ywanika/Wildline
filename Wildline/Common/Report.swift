//
//  Report.swift
//  Wildline
//
//  Created by Student on 11/26/25.
//

import Foundation

struct Report{
    var title: String?
    var userName: String?
    var userEmail: String?
    var userPhoneNumber: String?
    var description: String?
    var location: String?
    var status: String?
    
    init(title: String? = nil, userName: String? = nil, userEmail: String? = nil, userPhoneNumber: String? = nil, description: String? = nil, location: String? = nil, status: String? = nil) {
        self.title = title
        self.userName = userName
        self.userEmail = userEmail
        self.userPhoneNumber = userPhoneNumber
        self.description = description
        self.location = location
        self.status = status
    }
}
