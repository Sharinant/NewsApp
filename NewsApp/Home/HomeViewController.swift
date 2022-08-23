//
//  ViewController.swift
//  NewsApp
//
//  Created by Антон Шарин on 16.09.2021.
//

import UIKit
import PinLayout


class HomeViewController: UIViewController {
    
    var viewModel = HomeVM()
    var news : [News] = []
    var cellVM : [HomeCellViewModel] = []
    

    private var activityIndicator : UIActivityIndicatorView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator()
        view.backgroundColor = .gray
        title = "Главная"
        viewModel.delegate = self
        viewModel.loadLatestNews()
        createTable()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
    //   navigationController?.setNavigationBarHidden(true, animated: animated)
    //   navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false

    }

    let mainTable :  UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .gray
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    private func createTable () {
        
        mainTable.register(HomeCellTableView.self, forCellReuseIdentifier: HomeCellTableView.identifier)
        mainTable.delegate = self
        mainTable.dataSource = self
        
       
        let header = CustomHeader(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/4))
        header.setTitle(title: " Последние заголовки")
        
      // mainTable.tableHeaderView = header
        view.addSubview(mainTable)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainTable.frame = view.bounds
    }
    
    
    private func showActivityIndicator() {
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator?.color = .black
            activityIndicator?.hidesWhenStopped = true
            activityIndicator?.center = self.view.center
            self.mainTable.addSubview(activityIndicator!)
            activityIndicator?.startAnimating()
        }
    
    private func hideActivityIndicator() {
           if activityIndicator != nil {
               activityIndicator?.stopAnimating()
           }
       }
    

}

extension HomeViewController : HomeViewUpdate {
    
    func loadModels(models: [HomeCellViewModel]) {
        cellVM = models
        hideActivityIndicator()
        
    }
    
    func loadNews(news: [News]) {
        self.news = news
        mainTable.reloadData()
    }
    
    
   
    
   
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = mainTable.dequeueReusableCell(withIdentifier: HomeCellTableView.identifier) as? HomeCellTableView{
            cell.setup(with: cellVM[indexPath.row])
            cell.delegate = self
            cell.tag = indexPath.row
            cell.chechStar(aNew: news[indexPath.row])
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SelectedViewController(aNew: news[indexPath.row])
        vc.hidesBottomBarWhenPushed = true
        vc.navigationController?.navigationBar.isHidden = true 
        vc.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.pushViewController(vc, animated: true)
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    

}



extension HomeViewController : cellButtonClick {
    func clickStar(tag: Int) {
        viewModel.addToFavoriteOrDeleteFrom(new: news[tag])
    }
    
}
