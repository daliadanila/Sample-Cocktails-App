//
//  Cocktail.swift
//  Sample Cocktails App
//
//  Created by Dalia on 09/02/2020.
//  Copyright © 2020 Dalia Danila. All rights reserved.
//

import Foundation

struct Cocktail: Codable {
    
    let drinkID, drinkTitle, drinkTitleThumb: String
    
    let drinkIngredients: [String]

    enum CodingKeys: String, CodingKey {
        case drinkID, drinkTitle, drinkTitleThumb, drinkIngredients
    }
}

extension Cocktail {
    
    init?(data: Data) {
        
        guard let me = try? JSONDecoder().decode(Cocktail.self, from: data)
            
            else {
                
                return nil
        }
        self = me
    }
}
