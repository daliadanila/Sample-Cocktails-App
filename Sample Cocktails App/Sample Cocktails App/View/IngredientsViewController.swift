//
//  IngredientsViewController.swift
//  Sample Cocktails App
//
//  Created by Dalia on 09/02/2020.
//  Copyright © 2020 Dalia Danila. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class IngredientsViewController: UIViewController {

    @IBOutlet private weak var ingredientsTableView: UITableView!
    
    public var ingredients = PublishSubject<[String]>()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    
    private func setupBinding(){
        
     ingredientsTableView.register(UINib(nibName: "IngredientCell", bundle: nil), forCellReuseIdentifier: String(describing: IngredientCell.self))
        
        ingredients.bind(to: ingredientsTableView.rx.items(cellIdentifier: "IngredientCell", cellType: IngredientCell.self)) {  (row,ingredient,cell) in
            cell.cellIngredient = ingredient
            }.disposed(by: disposeBag)
        
        ingredientsTableView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
    }

}
