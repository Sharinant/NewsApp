//
//  SelectedViewModel.swift
//  NewsApp
//
//  Created by Антон Шарин on 19.10.2021.
//

import Foundation

protocol getReadyToShow : AnyObject {
    func sendURL(url : URLRequest)
}

protocol changeStarFill : AnyObject {
    func isIconFill(bool : Bool)
}

class SelectedViewModel  {
    
    weak var delegate : getReadyToShow?
    weak var delegateChange : changeStarFill?
    var new : News?
        
    
    
    func load() {
        returnRequest(urlString: new?.url ?? "")
        
        for aNew in favoriteNews {
            if aNew.url == new!.url {
                delegateChange?.isIconFill(bool: true)
            } }
    }
    
    func returnRequest(urlString : String) {
        let url = URLRequest(url: URL(string: urlString)!)
        delegate?.sendURL(url: url)
    }
    
    
    func addToFavoriteOrDeleteFrom() {
        
        delegateChange?.isIconFill(bool: true)
        
        for aNew in favoriteNews {
            if aNew.url == new!.url {
              
                let index = favoriteNews.firstIndex(where: {$0.url == new!.url})
                favoriteNews.remove(at: index!)
              //  favoriteNews = favoriteNews.uniqued()
                delegateChange?.isIconFill(bool: false)
                print(favoriteNews.count)
                return

            } }

        
        favoriteNews.insert(new!, at: 0)
        favoriteNews =  favoriteNews.uniqued()
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favoriteNews) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "fav")
        }
        print(favoriteNews.count)
}

    
    
}



extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
