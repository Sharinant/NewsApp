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
        tableView.backgroundColor = .systemBackground
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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
  
      
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
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.identifier) as? SearchResultsTableViewCell{
            cell.setup(with: cellVM[indexPath.row])
            return cell
        }
        return UITableViewCell()
        
    
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("123")
        
        let vc = SelectedViewController(aNew: news[indexPath.row])
        vc.navigationItem.largeTitleDisplayMode = .never
        
        self.tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        
        tabBarController?.tabBar.layer.zPosition = -1
        delegate?.showResult(vc)
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
