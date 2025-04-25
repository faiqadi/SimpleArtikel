//
//  UserDefault.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 25/04/25.
//

import UIKit
extension UserDefaults {
    private enum Keys {
        static let is_authenticated = "IS_AUTHENTICATED"
        static let username = "USERNAME"
        static let token = "TOKEN"
        
    }
    
    class var isAuthenticated: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.is_authenticated)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.is_authenticated)
        }
    }
    class var username: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.username) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.username)
        }
    }
    class var token: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.token) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.token)
        }
    }
}
