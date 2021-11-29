//
//  CustomHeader.swift
//  NewsApp
//
//  Created by Антон Шарин on 30.10.2021.
//

import UIKit

class CustomHeader: UIView {
    
    var title = "  Последние заголовки"
    
    public let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    private var labelHeight = NSLayoutConstraint()
    private var labelBottom = NSLayoutConstraint()
    private var containerView = UIView()
    private var containerviewHeight = NSLayoutConstraint()
    
      

    override init(frame : CGRect) {
        super.init(frame: frame)
        createViews()
        configure()
        setViewConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews() {
        
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        
    }
    
    func setTitle(title : String) {
        titleLabel.text = title
    }
    
    func configure() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        titleLabel.sizeToFit()
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
    }
    
    func setViewConstrains() {
        NSLayoutConstraint.activate([
                                        widthAnchor.constraint(equalTo: containerView.widthAnchor),
                                        centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                                        heightAnchor.constraint(equalTo: containerView.heightAnchor)])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
        containerviewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerviewHeight.isActive = true
        
        labelBottom = titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        labelBottom.isActive = true
        labelHeight = titleLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        labelHeight.isActive = true
    }
    
    public func scrollViewDidScroll(scrollView : UIScrollView) {
        
        containerviewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        labelBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        labelHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
        
    }
    
}



