//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Антон Шарин on 16.09.2021.
//

import Foundation


protocol HomeViewUpdate : AnyObject {
    func loadModels (models : [HomeCellViewModel])
    func loadNews (news : [News])
}

class HomeVM {
    
    var newsCells : [HomeCellViewModel] = []
    var news : [News] = []
    
    weak var delegate : HomeViewUpdate?
    
    func loadLatestNews() {
        loadDefaults()
        newsCells.removeAll()
        news.removeAll()
        APICaller.shared.getLatestNews { result in
            switch result {
            
            case .failure(let error) :
                print(error)
                
            case .success(let model) :
                let result = model.compactMap({return News(title: $0.title, description: $0.title, content: $0.content, url: $0.url, image: $0.image, published: $0.publishedAt, sourceName: $0.source.name, sourceUrl: $0.source.url)})
                self.news = result
                for aNew in self.news {
                    self.newsCells.append(HomeCellViewModel(news: aNew))
                }
                self.delegate?.loadModels(models: self.newsCells)
                self.delegate?.loadNews(news: self.news)
               // print(result[0])
            }
        }
        
    }
    
    func loadDefaults() {
        
        if let saved = UserDefaults.standard.object(forKey: "fav") as? Data {
            let decoder = JSONDecoder()
            if let loaded = try? decoder.decode([News].self, from: saved) {
                favoriteNews = loaded
            }
        }
    }
    
    func addToFavoriteOrDeleteFrom(new : News) {
        
        for aNew in favoriteNews {
            if aNew.url == new.url {
              
                let index = favoriteNews.firstIndex(where: {$0.url == new.url})
                favoriteNews.remove(at: index!)
              //  favoriteNews = favoriteNews.uniqued()
          //      print("favoriteNews.count")
                return

            } }

        
        favoriteNews.insert(new, at: 0)
        favoriteNews =  favoriteNews.uniqued()
       
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favoriteNews) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "fav")
        }
     //   print(favoriteNews.count)
        
}
    
}
