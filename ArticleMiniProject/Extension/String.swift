//
//  String.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

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
    
    
}

