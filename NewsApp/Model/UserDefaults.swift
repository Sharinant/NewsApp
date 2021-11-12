//
//  UserDefaults.swift
//  NewsApp
//
//  Created by Антон Шарин on 31.10.2021.
//

import Foundation


//final class UserFavorite {
//
//    private enum SettingsKeys : String {
//        case favorite
//    }
//
//    static var favoriteDefaults : [News]! {
//        get {
//            if let savedFav = UserDefaults.standard.object(forKey: "fav") as? Data {
//                let decoder = JSONDecoder()
//                if let loadedFav = try? decoder.decode(News.self, from: savedFav) {
//                    return [loadedFav]
//                } else {
//                    return [News]()
//                }
//            }
//        } set {
//            let encoder = JSONEncoder()
//            if let encoded = try? encoder.encode(newValue) {
//                let defaults = UserDefaults.standard
//                defaults.set(encoded, forKey: "fav")
//            }
//        }
//    }
//    
//
//}
