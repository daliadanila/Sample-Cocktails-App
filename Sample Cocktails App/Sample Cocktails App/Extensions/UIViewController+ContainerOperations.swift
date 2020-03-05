//
//  UIViewController+ContainerOperations.swift
//  Sample Cocktails App
//
//  Created by Dalia on 09/02/2020.
//  Copyright © 2020 Dalia Danila. All rights reserved.
//

import UIKit

extension UIViewController {
    public func add(asChildViewController viewController: UIViewController,to parentView:UIView) {
        
        addChild(viewController)
        
        parentView.addSubview(viewController.view)
        
        viewController.view.frame = parentView.bounds
        
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParent: self)
    }
    public func remove(asChildViewController viewController: UIViewController) {
        
        viewController.willMove(toParent: nil)
        
        viewController.view.removeFromSuperview()
        
        viewController.removeFromParent()
    }
}
