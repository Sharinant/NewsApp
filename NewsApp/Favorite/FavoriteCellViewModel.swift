//
//  FavoriteCellViewModel.swift
//  NewsApp
//
//  Created by Антон Шарин on 31.10.2021.
//

import Foundation


class FavoriteCellViewModel {
    
    var title = ""
    var date = ""
    var description = ""
    var image = ""
    var imageURL : URL?
    var sourceName = ""
    var url = ""
    
    required init (news : News) {
        
        self.title = news.title
        self.date = news.published
        self.description = news.description + " : " + news.title
        self.image = news.image
        self.sourceName = news.sourceName
        self.imageURL = strToUrl(str: news.image)
        self.url = news.url
    }
    
    
    func strToUrl(str : String) -> URL? {
        let url = URL(string: str)
        return url
    }
}
