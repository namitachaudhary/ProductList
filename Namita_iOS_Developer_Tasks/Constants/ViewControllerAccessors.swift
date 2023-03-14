//
//  ViewControllerAccessors.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Apple on 14/03/23.
//

import Foundation
import UIKit

class ViewControllerAccessors {

    static var productDetailsVc: ProductDetailsVC {
        if let viewController = StoryboardAccessors.mainStoryboard.instantiateViewController(withIdentifier: ViewControllersIdentifier.productDetailsVC.value) as? ProductDetailsVC {
            return viewController
        } else {
            return ProductDetailsVC()
        }
    }
}


 

