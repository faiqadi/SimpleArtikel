//
//  Converter.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 27/04/25.
//

import Foundation

class Converter{
    
    public static let standardDateFormat = "dd MMMM yyyy, HH:mm"
    
    
    public static func convertDateToString(Date date: Date, format: String = standardDateFormat) -> String{
        let dateFormatter = DateFormatter()
        print(date)
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        
        return dateFormatter.string(from: date)
    }
    
    public static func convertStringToDate(_ dateString: String, format: String?, lang: String = "en") -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format ?? standardDateFormat
        //        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        //        getCurrentLangCode()
        dateFormatter.locale = Locale(identifier: "id")
        return dateFormatter.date(from: dateString)
    }
    
}
