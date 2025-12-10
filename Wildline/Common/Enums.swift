//
//  Roles.swift
//  Wildline
//
//  Created by Max Grotstein on 12/7/25.
//

enum Roles: String, Codable {
    case User = "user"
    case Admin = "admin"
}

enum UpdateTypes: String, Codable {
    case Created = "Created"
    case Clamied = "Claimed"
    case OTW = "OTW"
    case Arrived = "Arrived"
    case Cancelled = "Cancelled"
    case Finished = "Finished"
}
