//
//  UserToken.swift
//  Wildline
//
//  Created by Max Grotstein on 11/18/25.
//

import Foundation
import FirebaseFirestore

class UserToken {
    static let shared = UserToken()
    private init() {}
    
    private let currentUserId = "currentUserId"
    private let currentUserRole = "currentUserRole"
    private let homeLocation = "homeLocation"
    let defaults = UserDefaults.standard
    
    // Save token
    func saveUserId(_ token: String) {
        defaults.set(token, forKey: currentUserId)
    }

    // Retrieve token
    func getUserId() -> String? {
        defaults.string(forKey: currentUserId)
    }

    // Delete token (logout)
    func clearUserId() {
        defaults.removeObject(forKey: currentUserId)
    }
    
    func saveUserRole(_ token: String) {
        defaults.set(token, forKey: currentUserRole)
    }
    
    func getUserRole() -> String? {
        defaults.string(forKey: currentUserRole)
    }
    
    func clearUserRole() {
        defaults.removeObject(forKey: currentUserRole)
    }
    
    func saveHomeLocation(_ token: GeoPoint) {
        defaults.set(token, forKey: homeLocation)
    }
    
    func getHomeLocation() -> GeoPoint? {
        (defaults.object(forKey: homeLocation) as! GeoPoint)
    }
    
    func clearHomeLocation() {
        defaults.removeObject(forKey: homeLocation)
    }
    
    func logout() {
        clearUserId()
        clearUserRole()
        clearHomeLocation()
        
        // Post notification that user logged out
        NotificationCenter.default.post(name: .userDidLogout, object: nil)
    }
}

extension Notification.Name {
    static let userDidLogout = Notification.Name("userDidLogout")
}
