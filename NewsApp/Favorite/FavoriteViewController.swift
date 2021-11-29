//
//  FavoriteViewController.swift
//  NewsApp
//
//  Created by Антон Шарин on 30.10.2021.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var cellVM : [FavoriteCellViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        createTable()
        // Do any additional setup after loading the view.
    }
    
    let mainTable :  UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .gray
        tableView.separatorStyle = .none
        return tableView
    }()

    private func createTable () {
        
        mainTable.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        mainTable.delegate = self
        mainTable.dataSource = self
        
       
        let header = CustomHeader(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/4))
        header.setTitle(title:"  Избранное")
        
        mainTable.tableHeaderView = header
        view.addSubview(mainTable)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainTable.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createModels()
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func createModels() {
        
        cellVM.removeAll()
        
        for aNew in favoriteNews {
            cellVM.append(FavoriteCellViewModel(news: aNew))
        }
        mainTable.reloadData()
        
    }
    
    
}


extension FavoriteViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = mainTable.dequeueReusableCell(withIdentifier: FavoriteCell.identifier) as? FavoriteCell{
            cell.setup(with: cellVM[indexPath.row])
            cell.tag = indexPath.row
            cell.backgroundColor = .gray
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = SelectedViewController(aNew: favoriteNews[indexPath.row])
        vc.navigationItem.largeTitleDisplayMode = .always
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           print("Deleted")
           favoriteNews.remove(at: indexPath.row)
           self.mainTable.beginUpdates()
           NotificationCenter.default.post(name: NSNotification.Name("ChangeFavStar"), object: nil)
           self.mainTable.deleteRows(at: [indexPath], with: .automatic)
           self.mainTable.endUpdates()
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(favoriteNews) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "fav")
            }
            
        }
    }

}

extension FavoriteViewController : cellButtonClick {
    
    func clickStar(tag: Int) {
        print(tag)
        
        favoriteNews.remove(at: tag)
        
        let indexPath = IndexPath(item: tag, section: 0)
        self.mainTable.deleteRows(at: [indexPath], with: .automatic)
        
    }
    
    
}
