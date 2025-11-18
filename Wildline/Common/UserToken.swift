//
//  UserToken.swift
//  Wildline
//
//  Created by Max Grotstein on 11/18/25.
//

import Foundation

class UserToken {
    static let shared = UserToken()
    private init() {}
    
    private let currentUserId = "currentUserId"
    private let currentUserRole = "currentUserRole"
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
}
