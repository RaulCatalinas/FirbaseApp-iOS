//
//  Storyboard+IDs.swift
//  FirbaseApp
//
//  Created by Tardes on 9/2/26.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    case home = "HomeScreen"

    var instance: UIStoryboard {
        UIStoryboard(name: rawValue, bundle: nil)
    }
}

enum StoryboardID {
    case mainViewController
    case homeTabBarController  // if you use one later

    var rawValue: String {
        switch self {
        case .mainViewController:
            return "MainViewController"
        case .homeTabBarController:
            return "HomeTabBarController"
        }
    }
}
