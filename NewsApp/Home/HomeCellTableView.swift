//
//  HomeCellTableView.swift
//  NewsApp
//
//  Created by Антон Шарин on 18.10.2021.
//

import UIKit
import SDWebImage


protocol cellButtonClick : AnyObject {
    func clickStar(tag : Int)
}


class HomeCellTableView: UITableViewCell {
    
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
        label.numberOfLines = 0
        return label
    }()
    
    let sourceLabel : UILabel = {
        let label = UILabel()
        label.text = "AAAAAAAAAAAAaaaaaaaaaaaaaaaaaaa"
        return label
    }()
    
    let favoriteButton : UIButton = {
        let button = UIButton()
      //  button.backgroundColor = .yellow
        button.tintColor = .yellow
        button.setImage(UIImage(systemName: "star"), for: .normal)
        return button
    }()
    

    public func setup(with vm : HomeCellViewModel)  {
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        titleLabel.text = vm.title
        imageViewNews.sd_setImage(with: vm.imageURL, completed: nil)
        favoriteButton.addTarget(self, action: #selector(starClicked), for: .touchUpInside)
        url = vm.url
        
        if vm.isInFav! {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
       
    
    for element in [imageViewNews,titleLabel,sourceLabel,favoriteButton] {
        contentView.addSubview(element)
    }
    
    
    }
    
    @objc func starClicked() {
        
        if favoriteButton.image(for: .normal) == UIImage(systemName: "star") {
            
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)

        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)

        }
        
        delegate?.clickStar(tag: self.tag)
       
        
    }
    
    public func setStarState() {
        
    }
    
    override func layoutSubviews() {
        contentView.pin.vertically(10).horizontally(5)
        imageViewNews.pin.left(10).vertically(15).height(100).width(100)
        titleLabel.pin.after(of: imageViewNews,aligned: .top).right(30).marginHorizontal(10).sizeToFit(.width).bottom()
     //   sourceLabel.pin.below(of: titleLabel,aligned: .left).width(of: titleLabel).marginTop(5).sizeToFit(.width).right(30).bottom(5)
        favoriteButton.pin.after(of: titleLabel,aligned: .top).width(25).height(25).marginLeft(5)
    }
}
