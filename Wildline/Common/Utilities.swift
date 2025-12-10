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
    
    static func getUser(for uid: String) async throws -> User {
        let db = Firestore.firestore()
        
        let document = db.collection("users").document(uid)
        let snapshot = try await document.getDocument()
        
        let user = try snapshot.data(as: User.self)
        
        return user
    }
    
    static func getReport(for rid: String) async throws -> Report {
        let db = Firestore.firestore()
        
        let document = db.collection("reports").document(rid)
        let snapshot = try await document.getDocument()
        
        let report = try snapshot.data(as: Report.self)
        
        return report
    }
    
    static func relativeString(from date: Date) -> String {
        let fmt = RelativeDateTimeFormatter()
        fmt.unitsStyle = .short
        return fmt.localizedString(for: date, relativeTo: Date())
    }
}
