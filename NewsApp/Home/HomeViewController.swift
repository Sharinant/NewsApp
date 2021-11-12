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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        title = "Главная"
        viewModel.delegate = self
        viewModel.loadLatestNews()
       createTable()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
       navigationController?.setNavigationBarHidden(true, animated: animated)
       navigationController?.navigationBar.isHidden = true
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
        
       
        let header = CustomHeader(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/3.5))
        header.setTitle(title: "  Последние заголовки")
        
        mainTable.tableHeaderView = header
        view.addSubview(mainTable)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainTable.frame = view.bounds
    }

}

extension HomeViewController : HomeViewUpdate {
    
    func loadModels(models: [HomeCellViewModel]) {
        cellVM = models
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
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SelectedViewController(aNew: news[indexPath.row])
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    

}

extension HomeViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = mainTable.tableHeaderView as? CustomHeader else {
            return
        }
        header.scrollViewDidScroll(scrollView: mainTable)
    }
}

extension HomeViewController : cellButtonClick {
    func clickStar(tag: Int) {
        viewModel.addToFavoriteOrDeleteFrom(new: news[tag])
    }
    
   
    
   
    
    
}
