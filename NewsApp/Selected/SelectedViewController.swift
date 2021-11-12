//
//  SelectedViewController.swift
//  NewsApp
//
//  Created by Антон Шарин on 25.10.2021.
//

import UIKit
import WebKit



class SelectedViewController: UIViewController {
    
    let viewModel = SelectedViewModel()
    var new : News?

    
    
    private let webView = WKWebView(frame: .zero)
    
    let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star"),
                                            style: .done,
                                            target: nil,
                                            action: #selector(didTapFavorite))

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.delegateChange = self
        viewModel.new = new
        viewModel.load()
        navigationItem.rightBarButtonItem = favoriteButton
        favoriteButton.target = self
        view.addSubview(webView)
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.pin.all(view.pin.safeArea)
        
    }

    convenience init(aNew : News) {
        self.init(nibName : nil,bundle : nil)
        self.new = aNew
    }

    
    @objc func didTapFavorite() {
        viewModel.addToFavoriteOrDeleteFrom()
       
    }
    
    
    
    
}


extension SelectedViewController : getReadyToShow {
    func sendURL(url: URLRequest) {
        webView.load(url)
    }
    
    
}

extension SelectedViewController : changeStarFill {
    func isIconFill(bool: Bool) {
        
        if bool {
            favoriteButton.image = UIImage(systemName: "star.fill")
        } else {
            favoriteButton.image = UIImage(systemName: "star")

        }
        
    }
    
    
}
