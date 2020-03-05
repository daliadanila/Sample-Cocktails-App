//
//  IngredientCell.swift
//  Sample Cocktails App
//
//  Created by Dalia on 09/02/2020.
//  Copyright © 2020 Dalia Danila. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    @IBOutlet weak var ingredientNameLabel : UILabel!
    
    
    public var cellIngredient : String! {
        didSet {
            self.ingredientNameLabel.text = cellIngredient
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.backgroundColor = .clear
    }
}
