//
//  String.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//
import Foundation

extension String {
    enum StringId: String {
        //A
        case artikel = "Artikel"
        //B
        case blog = "Blog"
        //E
        case email = "Email"
        //I
        case inputEmail = "Insert Your Email"
        case inpurPassword = "Insert Your Password"
        //L
        case login = "Login"
        //P
        case password = "Password"
        //R
        case report = "Report"
        case signUp = "Sign Up"
        //S
        case seeMore = "See More"
        
        
    }
    init(id: StringId) {
        self = id.rawValue
    }
    
    static func string(_ id: StringId) -> String {
        id.rawValue
    }
    
    func toDate() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        // Coba parse dengan fractional seconds dulu
        if let date = formatter.date(from: self) {
            return date
        }
        
        // Kalau gagal, coba lagi tanpa fractional seconds
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: self)
    }
    func convertDateToString(Date date: Date) -> String{
        let dateFormatter = DateFormatter()
        print(date)
        dateFormatter.calendar = Calendar(identifier: .gregorian)

        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        
        return dateFormatter.string(from: date)
    }
}

