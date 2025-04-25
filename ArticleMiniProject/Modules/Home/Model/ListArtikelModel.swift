//
//  ListArticleModel.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 25/04/25.
//

import ObjectMapper

// Model untuk respons API artikel
class ListArtikelModel: Mappable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Article]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        count    <- map["count"]
        next     <- map["next"]
        previous <- map["previous"]
        results  <- map["results"]
    }
}

// Model untuk artikel
class Article: Mappable {
    var id: Int?
    var title: String?
    var authors: [Author]?
    var url: String?
    var imageUrl: String?
    var newsSite: String?
    var summary: String?
    var publishedAt: String?
    var updatedAt: String?
    var featured: Bool?
    var launches: [String]?
    var events: [String]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id          <- map["id"]
        title       <- map["title"]
        authors     <- map["authors"]
        url         <- map["url"]
        imageUrl    <- map["image_url"]
        newsSite    <- map["news_site"]
        summary     <- map["summary"]
        publishedAt <- map["published_at"]
        updatedAt   <- map["updated_at"]
        featured    <- map["featured"]
        launches    <- map["launches"]
        events      <- map["events"]
    }
}

// Model untuk penulis
class Author: Mappable {
    var name: String?
    var socials: Socials?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name    <- map["name"]
        socials <- map["socials"]
    }
}

// Model untuk sosial media
class Socials: Mappable {
    var x: String?
    var youtube: String?
    var instagram: String?
    var linkedin: String?
    var mastodon: String?
    var bluesky: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        x          <- map["x"]
        youtube     <- map["youtube"]
        instagram   <- map["instagram"]
        linkedin    <- map["linkedin"]
        mastodon    <- map["mastodon"]
        bluesky     <- map["bluesky"]
    }
}
