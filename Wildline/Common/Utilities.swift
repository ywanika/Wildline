//
//  Utilities.swift
//  Wildline
//
//  Created by Max Grotstein on 11/26/25.
//

import Foundation
import FirebaseFirestore

class Utilities{
    static let userTypes = ["General User", "Rehabber"]
    
    static func parseLocation(location: String) -> GeoPoint? {
        let pattern = /^(-?\d+(?:\.\d+)?)\/(-?\d+(?:\.\d+)?)$/

        guard let match = location.wholeMatch(of: pattern) else {
            return nil
        }

        guard let lat = Double(match.1), let lon = Double(match.2) else {
            return nil
        }

        if !isValidCoordinate(latitude: lat, longitude: lon) {
            return nil
        }

        return GeoPoint(latitude: lat, longitude: lon)
    }
}
