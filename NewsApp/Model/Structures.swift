//
//  Structures.swift
//  NewsApp
//
//  Created by Антон Шарин on 17.09.2021.
//

import Foundation


struct Response : Codable {
    var totalArticles : Int
    var articles : [Articles]
    
    enum codingKeys : String,CodingKey {
        case totalArticles
        case articles
    }
}

struct Articles : Codable {
    var title : String
    var description : String
    var content : String
    var url : String
    var image : String
    var publishedAt : String
    var source : Source
            
    enum codingKeys : String,CodingKey {
        case title = "title"
        case description = "description"
        case content = "content"
        case url = "url"
        case image = "image"
        case published = "published"
        case source
    }
}

struct Source : Codable {
    var name : String
    var url : String
    
    enum codingKeys : String,CodingKey {
        case name = "name"
        case url = "url"
    }
}


struct News : Codable, Hashable {
    
    var title : String
    var description : String
    var content : String
    var url : String
    var image : String
    var published : String
    var sourceName : String
    var sourceUrl : String
    
    enum codingKeys : String,CodingKey {
        
        case title = "title"
        case description = "description"
        case content = "content"
        case url = "url"
        case image = "image"
        case published = "published"
        case sourceName = "sourceName"
        case sourceUrl = "sourceUrl"
    }
    
}
