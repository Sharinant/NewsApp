//
//  FavoriteCellTableView.swift
//  NewsApp
//
//  Created by Антон Шарин on 31.10.2021.
//

import Foundation
import UIKit



class FavoriteCell : UITableViewCell {
    
    var url = ""
    
    weak var delegate : cellButtonClick?
    
    static let identifier = "HomeCellTableViewIdentifier"

    let imageViewNews : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 5
        return label
    }()
    
    let sourceLabel : UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let favoriteButton : UIButton = {
        let button = UIButton()
      //  button.backgroundColor = .yellow
        button.tintColor = .yellow
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        return button
    }()
    

    public func setup(with vm : FavoriteCellViewModel)  {
        url = vm.url
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        titleLabel.text = vm.title
        imageViewNews.sd_setImage(with: vm.imageURL, completed: nil)
        favoriteButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
       
    
    for element in [imageViewNews,titleLabel,sourceLabel] {
        contentView.addSubview(element)
    }
    
    
    }
    
    @objc func buttonClick () {
        
        if favoriteButton.image(for: .normal) == UIImage(systemName: "star") {
            
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)

        } else {
            
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)

        }
        
        delegate?.clickStar(tag: self.tag)
    }
    
    override func layoutSubviews() {
        contentView.pin.vertically(10).horizontally(10)
        imageViewNews.pin.left(10).vertically(15).height(100).width(100)
        titleLabel.pin.after(of: imageViewNews,aligned: .top).right(30).marginHorizontal(10).sizeToFit(.widthFlexible).height(100)
      //  favoriteButton.pin.after(of: titleLabel,aligned: .top).width(25).height(25).marginLeft(5)
    }
}

