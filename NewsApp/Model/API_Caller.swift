//
//  API_Caller.swift
//  NewsApp
//
//  Created by Антон Шарин on 16.09.2021.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
     let APIkey = "d98f593f746d1c05b143b726c0a54ed7"
    
  
    func getLatestNews(completion : @escaping (Result<[Articles],Error>) -> Void) {
        
        let domen = "https://gnews.io/api/v4/top-headlines?token=" + APIkey + "&lang=ru" + "&max=10"
        guard let url = URL(string: domen) else {
            return
        }
        
        createRequest(url: url) { request in
            let task = URLSession.shared.dataTask(with: request) {(data,_,error) in
             //   print(url)
                if error != nil {
                    return
                }
                guard let data = data else {return}
            
            
            DispatchQueue.main.async {
                do {
                    let decoded = try JSONDecoder().decode(Response.self, from: data)
                    let modified = decoded.articles
            
                    completion(.success(modified))
                        
                    }
                        
                
            catch {
               completion(.failure(error))
            }
            }
        }
            task.resume()

    }
    
    
    }
    
    
    
    // Search
   private func createSearchDomen(q : String) -> String {
        
        let domen = "https://gnews.io/api/v4/search?q=" + q + "&token=" + APIkey + "&lang=ru"  + "&max=10"
        return domen
        
    }
    
    
    public func searchWith(with query:String, completion: @escaping (Result<[News], Error>)-> Void) {
        
        let queryPercentEncoded =
                   query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        
        let url = getURLsearch(query: queryPercentEncoded)
            
        createRequest(url : url!) { request in
                let task = URLSession.shared.dataTask(with: request) {data, _, error in
                    guard let data = data, error == nil else {
                        return
                    }
                
                    DispatchQueue.main.async {
                    do {
                        let decoded = try JSONDecoder().decode(Response.self, from: data)
                        let decodedModified = decoded.articles
                        let modified = decodedModified.compactMap { return News(title: $0.title,
                                                                        description: $0.description,
                                                                        content: $0.content,
                                                                        url: $0.url,
                                                                        image: $0.image,
                                                                        published: $0.publishedAt,
                                                                        sourceName: $0.source.name,
                                                                        sourceUrl: $0.source.url)
                            
                        }
                        completion(.success(modified))
                    } catch {
                        completion(.failure(error))
                    }
                }
                }
                task.resume()
            }
        }
    
    
    private func createRequest (url : URL, completion : @escaping (URLRequest) -> Void) {
        let request = URLRequest(url: url)
        completion(request)
    }
    
    private func getURLsearch(query: String) -> URL! {
           return URL(string: "https://gnews.io/api/v4/search?q=" + query + "&token=" + APIkey + "&lang=ru"  + "&max=10")
       }
    
}
