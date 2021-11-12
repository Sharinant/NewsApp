//
//  SearchView.swift
//  NewsApp
//
//  Created by Антон Шарин on 31.10.2021.
//

import UIKit

// View окна Search

class SearchView: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var results: [News] = []
    
    let searchController : UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultViewController())
        vc.searchBar.placeholder = "Ключевые слова, события... "
        vc.searchBar.backgroundColor = .darkGray
        vc.searchBar.tintColor = .black
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
        
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    
   
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
    }
    
   
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultsController = searchController.searchResultsController as? SearchResultViewController, let query = searchBar.text,
            !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        resultsController.delegate = self
                
        
        APICaller.shared.searchWith(with: query) { result in
            switch result {
            case .failure(let error):
                print("error - \(error)")
            case .success(let models):
                self.results = models
               resultsController.update(with: models)
                print(self.results[0].title)
            }
        }
        
        
    }
    

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
     
      
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let resultsController = searchController.searchResultsController as? SearchResultViewController,
              let query = searchController.searchBar.text,
            !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
       
        resultsController.delegate = self
        
    }
}

extension SearchView: SearchResultViewControllerDelegate{
    func showResult(_ controller: UIViewController) {
        
        controller.modalPresentationStyle = .overFullScreen
        
        show(controller, sender: nil)
        
     //  navigationController?.pushViewController(controller, animated: true)
       
        

    }
    
    
}
