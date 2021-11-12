//
//  SelectedViewController.swift
//  NewsApp
//
//  Created by Антон Шарин on 19.10.2021.
//

import Foundation
import UIKit

class SelectedViewControllerOldVersion: UIViewController {
   // let VM = SelectedViewModel()
    var new : News?
    var text : String = ""
    
    let imageView : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        return image
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.numberOfLines = 20
        label.textAlignment = .natural
        label.textColor = .white
        return label
    }()
    
    let sourceLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        return label
    }()
    
    let contentLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        return label
    }()
    
    
    
    
    
    convenience init(aNew : News) {
        self.init(nibName : nil,bundle : nil)
        
        self.new = aNew
        text = new!.content
        print(text)
        
    }
    
    private func setup () {
        titleLabel.text = new?.content
     //   contentLabel.text = new?.content
      //  sourceLabel.text = new?.sourceName
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
      //  print("selected")
        setup()
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeGestureRecognizerRight.direction = .right
        view.addGestureRecognizer(swipeGestureRecognizerRight)
    }
    
    @objc func swipe () {
        print("swipe")
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = .red
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeGestureRecognizerRight.direction = .right
        scrollView.addGestureRecognizer(swipeGestureRecognizerRight)
        view.addSubview(scrollView)
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
        
        imageView.frame = CGRect(x: scrollView.frame.minX + 1, y: scrollView.frame.minY + 10, width: scrollView.frame.width - 2, height: scrollView.frame.height/4)
       scrollView.addSubview(imageView)
        titleLabel.frame = CGRect(x: scrollView.frame.minX + 5, y: imageView.frame.maxY + 10, width: scrollView.frame.width - 20, height: scrollView.frame.height + 500)
        scrollView.addSubview(titleLabel)
    }
   
}
