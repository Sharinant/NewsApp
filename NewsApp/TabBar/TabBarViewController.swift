//
//  TabBarViewController.swift
//  NewsApp
//
//  Created by Антон Шарин on 25.10.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        let vc1 = HomeViewController()
        let vc2 = SearchView()
        let vc3 = FavoriteViewController()
        
    vc1.title = "Последние заголовки"
    vc2.title = "Поиск"
    vc3.title = "Избранное"
        
        let nav2 = UINavigationController(rootViewController: vc2)
        
      //  vc1.navigationItem.largeTitleDisplayMode = .always
        vc1.navigationController?.isNavigationBarHidden = true
        vc1.navigationController?.setNavigationBarHidden(true, animated: false)
        vc1.tabBarItem = UITabBarItem(title: "Главное", image: UIImage(systemName: "note.text"), tag : 1)
    
       // vc2.navigationController?.isNavigationBarHidden = true
      //  vc2.navigationController?.setNavigationBarHidden(true, animated: false)
        nav2.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag : 2)
        nav2.navigationItem.largeTitleDisplayMode = .always
        
        vc3.navigationController?.isNavigationBarHidden = true
        vc3.navigationController?.setNavigationBarHidden(true, animated: false)
        vc3.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "star.square"), tag : 1)
        
        setViewControllers([vc1,nav2,vc3], animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
