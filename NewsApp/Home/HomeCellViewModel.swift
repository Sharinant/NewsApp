//
//  HomeCellViewModel.swift
//  NewsApp
//
//  Created by Антон Шарин on 17.09.2021.
//

import Foundation


class HomeCellViewModel {
    
    var new : News?
    
    var title = ""
    var date = ""
    var description = ""
    var image = ""
    var imageURL : URL?
    var sourceName = ""
    var isInFav : Bool?
    var url = ""
    
    required init (news : News) {
        
        self.title = news.title
        self.date = news.published
        self.description = news.description + " : " + news.title
        self.image = news.image
        self.sourceName = news.sourceName
        self.imageURL = strToUrl(str: news.image)
        self.new = news
        self.isInFav = checkNewInFav()
        self.url = news.url
        
    }
    
    
    func strToUrl(str : String) -> URL? {
        let url = URL(string: str)
        return url
    }
    
     func checkNewInFav() -> Bool {
         
        if favoriteNews.contains(new!) {
            return true
        } else {
            return false
        }
    }
    
    
    
    
}
