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
        static let is_login = "IS_LOGIN"
        static let recent_search = "RECENT_SEARCH"
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
    class var isLogin: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.is_login)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.is_login)
        }
    }
    class var recentSearch: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: Keys.recent_search) ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.recent_search)
        }
    }
    
}
