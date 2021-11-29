//
//  SearchResultView.swift
//  NewsApp
//
//  Created by Антон Шарин on 31.10.2021.
//


import UIKit
import SDWebImage


protocol SearchResultViewControllerDelegate: AnyObject {
    func showResult(_ controller: UIViewController)
}

class SearchResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellVM.count
    }
    
    
    weak var delegate: SearchResultViewControllerDelegate?
    
    var news : [News] = []
    var cellVM : [SearchCellVM] = []
    
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .gray
        tableView.register(SearchResultsTableViewCell.self,
                           forCellReuseIdentifier: SearchResultsTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
    }()
    
    private let showEmptyLabel : UILabel = {
        let label = UILabel()
        label.text = "Ничего не найдено("
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.addSubview(showEmptyLabel)
        view.addSubview(tableView)
        view.backgroundColor = .gray
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
  
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.backgroundColor = .red
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.isHidden = false
        
    }
    
    private func createModels(news : [News]) {
        
        self.news = []
        cellVM.removeAll()
        
        for aNew in news {
            cellVM.append(SearchCellVM(news: aNew))
        }
        
    }
    
    func update(with results: [News]) {

        
        
        createModels(news: results)
        showEmptyLabel.isHidden = true
        self.news = results

        tableView.reloadData()
        tableView.isHidden = false

    }
    
    func noResults()  {
        
        tableView.isHidden = true
        showEmptyLabel.isHidden = false
        
    }
    
    func addToFavoriteOrDeleteFrom(new : News) {
        
        for aNew in favoriteNews {
            if aNew.url == new.url {
              
                let index = favoriteNews.firstIndex(where: {$0.url == new.url})
                favoriteNews.remove(at: index!)
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(favoriteNews) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "fav")
                }
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
        
}
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.identifier) as? SearchResultsTableViewCell{
            cell.setup(with: cellVM[indexPath.row])
            cell.backgroundColor = .gray
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.tag = indexPath.row
            cell.delegate = self
            cell.chechStar(aNew: news[indexPath.row])

            return cell
        }
        return UITableViewCell()
        
    
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = SelectedViewController(aNew: news[indexPath.row])
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.hidesBottomBarWhenPushed = true
        
        
        
        self.tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        
        delegate?.showResult(vc)
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension SearchResultViewController : cellButtonClick {
    
    func clickStar(tag: Int) {
        
    addToFavoriteOrDeleteFrom(new:news[tag])
        
    }
    
    
}
