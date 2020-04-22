//
//  CocktailsViewController.swift
//  Sample Cocktails App
//
//  Created by Dalia on 09/02/2020.
//  Copyright © 2020 Dalia Danila. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CocktailsViewController: UIViewController {
    
    @IBOutlet private weak var cocktailsCollectionView: UICollectionView!
    
    
    public var cocktails = PublishSubject<[Cocktail]>()
    
    public let selectedCocktailIngredients: PublishSubject<[String]> = PublishSubject()
    
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupBinding()
        
        displayIngredients()
    }
    
    
    private func setupBinding(){
        
        cocktailsCollectionView.register(UINib(nibName: "CocktailCell", bundle: nil), forCellWithReuseIdentifier: String(describing: CocktailCell.self))
        
        cocktails.bind(to: cocktailsCollectionView.rx.items(cellIdentifier: "CocktailCell", cellType: CocktailCell.self)) {  (row,cocktail,cell) in
            cell.cellCocktail = cocktail
        }.disposed(by: disposeBag)
        
        cocktailsCollectionView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, 0, -250, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
        
    }
    
    private func displayIngredients() {
        
        cocktailsCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let cell = self?.cocktailsCollectionView.cellForItem(at: indexPath) as! CocktailCell
                
                let cocktail = cell.cellCocktail!
                
                self?.selectedCocktailIngredients.onNext(cocktail.drinkIngredients)
                
            })
            .disposed(by: disposeBag)
        
    }

}
