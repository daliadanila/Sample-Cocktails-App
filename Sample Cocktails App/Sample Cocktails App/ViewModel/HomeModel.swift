//
//  HomeModel.swift
//  Sample Cocktails App
//
//  Created by Dalia on 09/02/2020.
//  Copyright © 2020 Dalia Danila. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeModel {
    
    public enum HomeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public let cocktails : PublishSubject<[Cocktail]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<HomeError> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    
    public func requestCocktailData(){
        
     //   self.loading.onNext(true)
        APIManager.requestData(url: Constants.cocktailsURL, method: .get, parameters: nil, completion: { (result) in
         //   self.loading.onNext(false)
            switch result {
            case .success(let returnJson) :
                let cocktails = returnJson.arrayValue.compactMap {
                    
                    return Cocktail(data: try! $0.rawData())
                    
                }
                self.cocktails.onNext(cocktails)
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self.error.onNext(.internetError("Check your Internet connection."))
                case .authorizationError(let errorJson):
                    self.error.onNext(.serverMessage(errorJson["message"].stringValue))
                default:
                    self.error.onNext(.serverMessage("Unknown Error"))
                }
            }
        })
        
    
    }
}

