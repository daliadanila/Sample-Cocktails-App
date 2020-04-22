//
//  HomeViewController.swift
//  Sample Cocktails App
//
//  Created by Dalia on 09/02/2020.
//  Copyright © 2020 Dalia Danila. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet weak var cocktailsView: UIView!
    
    @IBOutlet weak var ingredientsView: UIView!
    
    private lazy var cocktailsViewController: CocktailsViewController = {

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var vc = storyboard.instantiateViewController(withIdentifier: "CocktailsViewController") as! CocktailsViewController
        
        self.add(asChildViewController: vc, to: cocktailsView)
        
        return vc
    }()
    
    
    private lazy var ingredientsViewController: IngredientsViewController = {

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var vc = storyboard.instantiateViewController(withIdentifier: "IngredientsViewController") as! IngredientsViewController
        
        self.add(asChildViewController: vc, to: ingredientsView)
        
        return vc
    }()
    
    
    var homeModel = HomeModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupBindings()
        homeModel.requestCocktailData()
        
        cocktailsViewController
            .selectedCocktailIngredients
            .asObservable()
            .subscribe { [weak self] cocktailEvent in
                
                self?.ingredientsViewController.ingredients.on(cocktailEvent)
                
        }
            
        .disposed(by: disposeBag)
        
    }
    
    private func setupBindings() {
        
        // binding loading to vc
        
    //    homeModel.loading
    //        .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        
        homeModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internetError(let message):
            
                    let alertController = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
                    
                    alertController.show(self, sender: self)
                    
                case .serverMessage(let message):

                    let alertController = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
                    
                    alertController.show(self, sender: self)
                }
            })
            .disposed(by: disposeBag)
        
        
        homeModel
            .cocktails
            .observeOn(MainScheduler.instance)
            .bind(to: cocktailsViewController.cocktails)
            .disposed(by: disposeBag)
        

        
    }
    
}
