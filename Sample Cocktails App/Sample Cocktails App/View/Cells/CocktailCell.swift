//
//  CocktailCell.swift
//  Sample Cocktails App
//
//  Created by Dalia on 09/02/2020.
//  Copyright © 2020 Dalia Danila. All rights reserved.
//

import UIKit


class CocktailCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cocktailImage: UIImageView!
    @IBOutlet weak var cocktailTitle: UILabel!
    
    private lazy var backView: UIImageView = {
        let backView = UIImageView(frame: cocktailImage.frame)
        backView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(backView)
        backView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        backView.alpha = 0.5
        contentView.bringSubviewToFront(cocktailImage)
        return backView
    }()
    public var cellCocktail: Cocktail! {
        didSet {
            self.cocktailImage.loadImage(fromURL: cellCocktail.drinkTitleThumb)
            self.cocktailTitle.text = cellCocktail.drinkTitle
        }
    }
}
