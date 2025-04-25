//
//  BaseErrorResponse.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 25/04/25.
//

import ObjectMapper


struct BaseErrorResponse: Mappable, Error {
    var code: String = ""
    var status: String = ""
    var message: String = ""

    init(code: String = "",
         status: String = "",
         message: String = "") {
        self.code = code
        self.status = status
        self.message = message
    }

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        code <- map["code"]
        status <- map["status"]
        message <- map["message"]
    }
}
enum DataState<Element> {
    /// Initiate
    case initiate
    
    /// Loading
    case loading
    
    /// Next element is produced.
    case next(Element)

    /// Sequence terminated with an error.
    case error(Swift.Error)

    /// Sequence completed successfully.
    case completed
}
