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
    case Claimed = "Claimed"
    case OTW = "OTW"
    case Arrived = "Arrived"
    case Withdrawn = "Withdrawn"
    case Finished = "Finished"
    case Cancelled = "Cancelled"
}

let updateOrder: [UpdateTypes] = [UpdateTypes.Created, UpdateTypes.Claimed, UpdateTypes.OTW, UpdateTypes.Arrived, UpdateTypes.Finished]
