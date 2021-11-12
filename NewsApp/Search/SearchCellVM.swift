//
//  SearchCellVM.swift
//  NewsApp
//
//  Created by Антон Шарин on 31.10.2021.
//

import Foundation


class SearchCellVM {
    
    var new : News?
    
    var title = ""
    var date = ""
    var description = ""
    var image = ""
    var imageURL : URL?
    var sourceName = ""
    var isInFav : Bool?
    
    required init (news : News) {
        
        self.new = news
        self.title = news.title
        self.date = news.published
        self.description = news.description + " : " + news.title
        self.image = news.image
        self.sourceName = news.sourceName
        self.imageURL = strToUrl(str: news.image)
        self.isInFav = check()
        
    }
    
    
    func strToUrl(str : String) -> URL? {
        let url = URL(string: str)
        return url
    }
    
    func check() -> Bool {
       if favoriteNews.contains(new!) {
           return true
       } else {
           return false
       }
   }
}
