//
//  AppDelegate.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Apple on 14/03/23.
//

import Foundation
import UIKit

class StoryboardAccessors: NSObject {
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: StoryBoardName.main.value, bundle: nil)
    }
}

